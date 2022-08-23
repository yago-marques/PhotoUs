//
//  PostViewModel.swift
//  PhotoUs
//
//  Created by Yago Marques on 22/08/22.
//

import Foundation

final class PostViewModel {
    
    var posts: [Post] = [] {
        didSet {
            reloadCollection()
        }
    }
    private var session: UserSession
    private var api: API
    weak var delegate: PostsViewControllerDelegate?
    
    init(api: API, session: UserSession, delegate: PostsViewControllerDelegate? = nil) {
        self.api = api
        self.session = session
        self.delegate = delegate
    }
    
    func fetchPosts() async {
        
        guard let url = api.getUrl(path: "/posts") else {
            return
        }

        let request = api.getRequest(url: url, method: .get)
        
        guard let postsData = await api.Get(request: request) else {
            return
        }

        do {
            let posts = try JSONDecoder().decode([Post].self, from: postsData)
            let postsWithAuthors = try await getPostsWithAuthors(posts: posts)
            self.posts = postsWithAuthors
        } catch {
            print(error)
        }
    }

}

private extension PostViewModel {
    private func reloadCollection() {
        DispatchQueue.main.async {
            self.delegate?.updateCollection()
        }
    }
    
    private func newPostWithText(token: String, text: String, callback: @escaping (Result<Int, APIError>) -> Void) {

        guard let url = api.getUrl(path: "/posts") else {
            callback(.failure(.invalidURL))
            return
        }

        let headers = ["Content-Type": "text/plain"]
        let data = text.data(using: .utf8)

        var request = api.getRequest(url: url, method: .post, headers: headers, body: data)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        api.Post(request: request) { result in
            switch result {
            case let .success(tupla):
                let (_, response, error) = tupla
                if error != nil {
                    callback(.failure(.network(error)))
                    return
                } else {
                    let res = response as! HTTPURLResponse
                    callback(.success(res.statusCode))
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    private func fetchAuthor(userId: String) async -> UserData? {
        guard let url = api.getUrl(path: "/users/\(userId)") else { return nil }
        let request = api.getRequest(url: url)
        
        guard let authorData = await api.Get(request: request) else { return nil }
        
        do {
            
            let author = try JSONDecoder().decode(UserData.self, from: authorData)
            return author
            
        } catch {
            print(error)
        }
        
        return nil
    }
    
    private func getPostsWithAuthors(posts: [Post]) async throws -> [Post] {
        let myPosts: [Post] = await posts.asyncMap { post in
            var newPost = post
            let author = await fetchAuthor(userId: post.author)
            newPost.author = author?.name ?? "Unknow Author"
            newPost.createdAt = getDate(stringDate: post.createdAt)
            newPost.updatedAt = getDate(stringDate: post.updatedAt)
            
            return newPost
        }
        
        return myPosts
    }
    
    private func getDate(stringDate: String) -> String {
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from: stringDate)!
        
        return date.getFormattedDate(format: "dd/MM/yyyy")
    }
}

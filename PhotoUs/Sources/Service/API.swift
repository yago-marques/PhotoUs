//
//  API.swift
//  PhotoUs
//
//  Created by Yago Marques on 09/08/22.
//

import UIKit

final class API {
            
    static func postUser(user: User, callback: @escaping (Result<UserSession, APIError>) -> Void) {
        guard let url = getUrl(path: "/users") else {
            callback(.failure(.invalidURL))
            return
        }
        
        let body: Data = try! JSONEncoder().encode(user)
        
        let headers = [
            "accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        let request = getRequest(url: url, method: .post, headers: headers, body: body)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                callback(.failure(.network(error)))
                return
            }
            
            do {
                let userSession = try JSONDecoder().decode(UserSession.self, from: data)
                callback(.success(userSession))
            } catch {
                callback(.failure(.invalidEmail(error)))
            }
            
        }
        
        task.resume()
    }
    
    static func login(email: String, password: String, callback: @escaping (Result<UserSession, APIError>) -> Void) {
        
        guard let url = getUrl(path: "/users/login") else {
            callback(.failure(.invalidURL))
            return
        }
        
        var request = getRequest(url: url, method: .post)
        let authData = (email + ":" + password).data(using: .utf8)!.base64EncodedString()
        request.addValue("Basic \(authData)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                callback(.failure(.network(error)))
                return
            }
            
            do {
                let session = try JSONDecoder().decode(UserSession.self, from: data)
                callback(.success(session))
            } catch {
                callback(.failure(.invalidEmail(error)))
            }

        }
        
        task.resume()
        
    }
    
}

private extension API {
        
    static private func getUrl(path: String, queries: [APIQuery] = []) -> URL? {
        guard var components = URLComponents(string: BaseURL.locally.rawValue) else {
            return nil
        }
        
        let queries: [URLQueryItem] = {
            let myQueries = queries.map { query in
                URLQueryItem(name: query.name, value: query.value)
            }
            
            return myQueries
        }()
        
        components.path = path
        components.scheme = "http"
        components.queryItems = queries
        
        return components.url
    }
    
    static private func getRequest(
        url: URL,
        method: HTTPMethods = .get,
        headers: [String: String] = ["accept": "application/json"],
        body: Data? = nil
    ) -> URLRequest {
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        
        return request
        
    }
    
}

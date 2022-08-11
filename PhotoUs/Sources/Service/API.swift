//
//  API.swift
//  PhotoUs
//
//  Created by Yago Marques on 09/08/22.
//

import UIKit

enum BaseURL: String {
    case locally = "http://127.0.0.1:8080"
    case remotely = "http://adaspace.local"
}

enum APIError: Error {
    case invalidURL
    case invalidEmail(Error?)
    case network(Error?)
}

final class API {
    
    func postUser(user: User, callback: @escaping (Result<UserSession, APIError>) -> Void) {
        guard let url = getUrl(path: "/users") else {
            callback(.failure(.invalidURL))
            return
        }
        let bodyRequest: Data = try! JSONEncoder().encode(user)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Content-Type": "application/json"
        ]
        request.httpBody = bodyRequest
        
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
    
}

private extension API {
        
    private func getUrl(path: String, queries: [APIQuery] = []) -> URL? {
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
    
}

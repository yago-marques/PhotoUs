//
//  API.swift
//  PhotoUs
//
//  Created by Yago Marques on 09/08/22.
//

import UIKit

enum ServiceError: Error {
    case invalidURL
    case network(Error?)
}

final class Service {
    
    private var baseURL = "http://adaspace.local"
    
    func postUsers(user: User, callback: @escaping (Result<Any, ServiceError>) -> Void) {
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
            
            
            
        }
        
        task.resume()
    }
    
}

private extension Service {
        
    private func getUrl(path: String, queries: [APIQuery] = []) -> URL? {
        guard var components = URLComponents(string: baseURL) else {
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

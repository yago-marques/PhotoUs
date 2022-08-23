//
//  API.swift
//  PhotoUs
//
//  Created by Yago Marques on 09/08/22.
//

import UIKit

// Adaptar pra testar!! Não será estatica

final class API {
    
    func Post(
        request: URLRequest,
        callback: @escaping (Result<(Data?, URLResponse?, Error?), APIError>) -> Void
    ) {
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            callback(.success((data, response, error)))
        }
        
        task.resume()

    }
    
    func Get(request: URLRequest) async -> Data? {
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return data
        } catch {
            print(error)
        }
        
        return nil
    }
    
}

extension API {
        
    func getUrl(path: String, queries: [APIQuery] = []) -> URL? {
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
    
    func getRequest(
        url: URL,
        method: HTTPMethods = .get,
        headers: [String: String] = ["Content-Type": "application/json", "Accept": "application/json"],
        body: Data? = nil
    ) -> URLRequest {
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        
        return request
        
    }
    
}

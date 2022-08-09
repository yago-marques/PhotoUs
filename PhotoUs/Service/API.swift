//
//  API.swift
//  PhotoUs
//
//  Created by Yago Marques on 09/08/22.
//

import UIKit

enum ServiceError: Error {
    case invalidURL
}

final class Service {
    
    private var baseURL = "http://adaspace.local"
    
    func postUsers(user: User, callback: @escaping (Result<Any, ServiceError>) -> Void) {
        
        guard let url = URL(string: baseURL.appending("/users")) else {
            callback(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        
        
    }
    
}

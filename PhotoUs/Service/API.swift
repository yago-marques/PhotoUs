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
    
    func postUser(user: User, callback: @escaping (Result<UserSession, ServiceError>) -> Void) {
        
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
        
        request.httpBody = try? JSONEncoder().encode(user)
        
        let task = URLSession.shared.dataTask(with: request){data,error,response in
            
        }
        
        task.resume()
    }
    
    func getPosts (callback:@escaping (Result<Any,ServiceError>) -> Void){
        guard let url = URL(string: baseURL.appending("/posts")) else{
            callback(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url:url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "accept":"application/json"
        ]
        
        let task = URLSession.shared.dataTask(with: request){data,response,error in
            
        }
        
        task.resume()
    }
}

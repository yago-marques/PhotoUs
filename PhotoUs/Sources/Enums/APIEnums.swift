//
//  APIEnums.swift
//  PhotoUs
//
//  Created by Yago Marques on 12/08/22.
//

import Foundation

enum BaseURL: String {
    case locally = "http://127.0.0.1:8080"
    case remotely = "http://adaspace.local"
}

enum APIError: Error {
    case invalidURL
    case invalidEmail(Error?)
    case network(Error?)
}

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

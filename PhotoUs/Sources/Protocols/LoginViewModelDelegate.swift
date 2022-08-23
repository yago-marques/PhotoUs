//
//  LoginViewModelDelegate.swift
//  PhotoUs
//
//  Created by Yago Marques on 22/08/22.
//

import Foundation

protocol LoginViewModelDelegate: AnyObject {
    func makeLogin(email: String, password: String, callback: @escaping (Result<UserSession, APIError>) -> Void)
}

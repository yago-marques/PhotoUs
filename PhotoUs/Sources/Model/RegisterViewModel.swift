//
//  RegisterViewModel.swift
//  PhotoUs
//
//  Created by Yago Marques on 10/08/22.
//

import Foundation

final class RegisterViewModel {
    
    var userSession: UserSession?
    
    private let api = API()
    
    func registerNewUser(_ user: User, callback: @escaping (Result<UserSession, APIError>) -> Void) {
        do {
            api.postUser(user: user) { result in
                DispatchQueue.main.async {
                    switch result {
                    case let .success(userSession):
                        self.userSession = userSession
                        callback(.success(userSession))
                    case let .failure(error):
                        print(error.localizedDescription)
                        callback(.failure(.invalidEmail(error)))
                    }
                }
            }
        }
    }
    
}

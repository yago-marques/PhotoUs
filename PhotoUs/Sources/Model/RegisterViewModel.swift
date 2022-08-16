//
//  RegisterViewModel.swift
//  PhotoUs
//
//  Created by Yago Marques on 10/08/22.
//

import Foundation

final class RegisterViewModel {
    
    var userSession: UserSession?
    
    func registerNewUser(_ user: User, callback: @escaping (Result<UserSession, APIError>) -> Void) {
        do {
            API.postUser(user: user) { result in
                DispatchQueue.main.async {
                    switch result {
                    case let .success(userSession):
                        self.userSession = userSession
                        self.guardToken(with: userSession)
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

private extension RegisterViewModel {
    
    private func guardToken(with session: UserSession) {
        
        guard let userSession = try? JSONEncoder().encode(session) else { return }
        
        do {
            try Keychain.create(
                session: userSession,
                service: AppIdentifiers.bundleID,
                account: AppIdentifiers.bundleID
            )
        } catch {
            print(error)
        }
    }
    
}

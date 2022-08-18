//
//  LoginViewModel.swift
//  PhotoUs
//
//  Created by Yago Marques on 12/08/22.
//

import Foundation
import UIKit

final class LoginViewModel {
    
    // API como dependencia para testar (Sugiro URLProtocol)
    
    var userSession: UserSession?
    
    func trySession() -> UserSession? {
        
        if Keychain.hasSession() {
            do {
                let session = try Keychain.read(service: AppIdentifiers.bundleID, account: AppIdentifiers.bundleID)
                self.userSession = session
                return session
            } catch {
                print(error)
            }
        }
        
        return nil
    }
    
    func login(
        email: String,
        password: String,
        callback: @escaping (Result<UserSession, APIError>) -> Void
    ) {
        API.login(email: email, password: password) { result in
            switch result {
            case let .success(session):
                self.userSession = session
                Keychain.createSession(session)
                callback(.success(session))
                print("logado")
            case let .failure(error):
                callback(.failure(error))
            }
        }
    }
}

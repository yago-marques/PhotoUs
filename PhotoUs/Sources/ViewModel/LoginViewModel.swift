//
//  LoginViewModel.swift
//  PhotoUs
//
//  Created by Yago Marques on 12/08/22.
//

import Foundation
import UIKit

final class LoginViewModel {
    
    var userSession: UserSession?
    private var api: API
    
    init(api: API) {
        self.api = api
    }
    // API como dependencia para testar (Sugiro URLProtocol)
    
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
        self.makeLogin(email: email, password: password) { result in
            switch result {
            case let .success(session):
                self.userSession = session
                Keychain.createSession(session)
                callback(.success(session))
            case let .failure(error):
                callback(.failure(error))
            }
        }
    }
}

extension LoginViewModel: LoginViewModelDelegate {
    func makeLogin(email: String, password: String, callback: @escaping (Result<UserSession, APIError>) -> Void) {
        
        guard let url = api.getUrl(path: "/users/login") else {
            callback(.failure(.invalidURL))
            return
        }
        
        var request = api.getRequest(url: url, method: .post)
        let authData = (email + ":" + password).data(using: .utf8)!.base64EncodedString()
        request.addValue("Basic \(authData)", forHTTPHeaderField: "Authorization")
        
        api.Post(request: request) { result in
            switch result {
            case let .success(tuple):
                let (data, _, error) = tuple
                
                guard let data = data else {
                    callback(.failure(.network(error)))
                    return
                }
                
                do {
                    let session = try JSONDecoder().decode(UserSession.self, from: data)
                    callback(.success(session))
                } catch {
                    callback(.failure(.invalidEmail(error)))
                }
            case let .failure(error):
                print(error)
            }
        }
        
    }
}

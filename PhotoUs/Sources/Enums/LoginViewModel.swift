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
        emailTextField: UITextField,
        passwordTextField: UITextField,
        callback: @escaping (Result<UserSession, APIError>) -> Void

    ) {
        
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        API.login(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(session):
                    self.userSession = session
                    Keychain.guardSession(session)
                    callback(.success(session))
                    print("logado")
                case let .failure(error):
                    callback(.failure(error))
                }
            }
        }
        
    }
    
}

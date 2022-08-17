//
//  RegisterViewModel.swift
//  PhotoUs
//
//  Created by Yago Marques on 10/08/22.
//

import UIKit

final class RegisterViewModel {
    
    var userSession: UserSession?
    
    func registerNewUser(
        nameTextField: UITextField,
        emailTextField: UITextField,
        passwordTextField: UITextField,
        callback: @escaping (Result<UserSession, APIError>) -> Void
    ) {
        guard let name = nameTextField.text else { return }
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        let user = User(name: name, email: email, password: password)
        
        do {
            API.postUser(user: user) { result in
                DispatchQueue.main.async {
                    switch result {
                    case let .success(userSession):
                        self.userSession = userSession
                        Keychain.guardSession(userSession)
                        callback(.success(userSession))
                        print("cadastrado")
                    case let .failure(error):
                        print(error.localizedDescription)
                        callback(.failure(.invalidEmail(error)))
                    }
                }
            }
        }
    }
    
}

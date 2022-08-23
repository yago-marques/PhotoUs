//
//  RegisterViewModel.swift
//  PhotoUs
//
//  Created by Yago Marques on 10/08/22.
//

import UIKit

final class RegisterViewModel {
    
    var userSession: UserSession?
    private let api: API
    weak var delegate: LoginViewModelDelegate?
    
    init(api: API, delegate: LoginViewModelDelegate) {
        self.api = api
        self.delegate = delegate
    }
    
    func registerNewUser(
        name: String,
        email: String,
        password: String,
        callback: @escaping (Result<UserSession, APIError>) -> Void
    ) {
        
        let user = User(name: name, email: email, password: password)
        
        do {
            self.postUser(user: user) { result in
                switch result {
                case let .success(userSession):
                    self.userSession = userSession
                    Keychain.createSession(userSession)
                    self.delegate?.makeLogin(email: email, password: password) { result in
                        switch result {
                        case let .failure(error):
                            print(error)
                        case let .success(session):
                            callback(.success(session))
                            print("cadastrado")
                        }
                    }
                    
                case let .failure(error):
                    print(error.localizedDescription)
                    callback(.failure(.invalidEmail(error)))
                }
            }
        }
    }
    
}

private extension RegisterViewModel {
    private func postUser(user: User, callback: @escaping (Result<UserSession, APIError>) -> Void) {
        guard let url = api.getUrl(path: "/users") else {
            callback(.failure(.invalidURL))
            return
        }
        
        let body: Data = try! JSONEncoder().encode(user)
        
        let headers = [
            "accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        let request = api.getRequest(url: url, method: .post, headers: headers, body: body)
        
        api.Post(request: request) { result in
            switch result {
            case let .success(tuple):
                let (data, _, error) = tuple
                guard let data = data else {
                    callback(.failure(.network(error)))
                    return
                }
                
                do {
                    let userSession = try JSONDecoder().decode(UserSession.self, from: data)
                    callback(.success(userSession))
                } catch {
                    callback(.failure(.invalidEmail(error)))
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}

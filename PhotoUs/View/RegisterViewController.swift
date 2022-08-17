//
//  LoginViewController.swift
//  PhotoUs
//
//  Created by Yago Marques on 09/08/22.
//

import UIKit

final class RegisterViewController: UIViewController {
    
    var service = Service()
    let user = User(name: "mariazinha", email: "yagodevios@maria.com", password: "senha123")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
    func verifySession() {
        let bundleId = Bundle.main.bundleIdentifier!
        
        do {
            let tokenData = try Keychain.read(service: bundleId, account: bundleId)
            
            guard let token = String(data: tokenData, encoding: .utf8) else { return }
            
            print(token)
        } catch {
            print(error)
        }
        
    }
    
    func newUser() {
        service.postUser(user: user) { result in
            switch result{
            case let .success(session):
                let token = Data(session.token.utf8)
                let bundleId = Bundle.main.bundleIdentifier!
                
                do {
                    
                    if Keychain.isValid(service: bundleId, account: bundleId) {
                        try Keychain.save(token: token, service: bundleId, account: bundleId)
                    } else {
                        try Keychain.update(newToken: token, service: bundleId, account: bundleId)
                    }
                    
                } catch {
                    print(error)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
}

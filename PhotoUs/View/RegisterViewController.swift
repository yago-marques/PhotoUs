//
//  LoginViewController.swift
//  PhotoUs
//
//  Created by Yago Marques on 09/08/22.
//

import UIKit

final class RegisterViewController: UIViewController {
    
    var service = Service()
    let user = User(name: "mariazinha", email: "maria@maria.com", password: "senha123")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        service.postUser(user: user) { result in
            switch result{
            case let .success(session):
                let token = Data(session.token.utf8)
                let bundleId = Bundle.main.bundleIdentifier!
                
                do {
                    try Keychain.save (token: token, service: bundleId, account: bundleId)
                }catch{
                    print(error)
                }
            case let .failure(error):
                print(error)
            }
            
            
        }
        view.backgroundColor = .white
    }
    
}

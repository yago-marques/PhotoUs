//
//  LoginViewController.swift
//  PhotoUs
//
//  Created by Yago Marques on 09/08/22.
//

import UIKit

final class RegisterViewController: UIViewController {
    
    private let viewModel = RegisterViewModel()
    let user = User(name: "yaguin", email: "hfhgfsagh@gmail.com", password: "yago123")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newUser(user)
        
        buildLayout()
    }
    
}

private extension RegisterViewController {
    
    private func newUser(_ user: User) {
        
        viewModel.registerNewUser(user) { result in
            switch result {
            case let .success(session):
                print(session.token)
                // persistir token
            case let .failure(error):
                print(error.localizedDescription)
                // provavelmente email inválido
            }
        }
    
    }
    
}

extension RegisterViewController: ViewCoding {
    
    func setupView() {
        view.backgroundColor = .white
    }
    
    func setupConstraints() { }
    
    func setupHierarchy() { }
    
}

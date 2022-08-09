//
//  LoginViewController.swift
//  PhotoUs
//
//  Created by Yago Marques on 09/08/22.
//

import UIKit

final class RegisterViewController: UIViewController {
    
    var service = Service()
    let user = User(name: "yago", email: "yago@yago.com", password: "yago123")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        service.postUsers(user: user) { result in
            print(result)
        }
        view.backgroundColor = .white
    }
    
}

//
//  LoginViewController.swift
//  PhotoUs
//
//  Created by Yago Marques on 09/08/22.
//

import UIKit

final class RegisterViewController: UIViewController {
    
    var service = Service()
    let user = User(name: "thays", email: "thsavdhgvdhgv@thays.com", password: "thays123")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        service.postUser(user: user) { result in
            print(result)
        }
        view.backgroundColor = .white
    }
    
}

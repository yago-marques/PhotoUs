//
//  LoginViewControllerDelegate.swift
//  PhotoUs
//
//  Created by Yago Marques on 15/08/22.
//

import UIKit

protocol LoginViewControllerDelegate {
    func goToRegisterView()
    func userLogin(email: UITextField, password: UITextField)
}

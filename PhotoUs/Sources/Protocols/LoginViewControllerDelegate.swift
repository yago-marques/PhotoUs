//
//  LoginViewControllerDelegate.swift
//  PhotoUs
//
//  Created by Yago Marques on 15/08/22.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    func goToRegisterView()
    func userLogin(email: String?, password: String?)
}

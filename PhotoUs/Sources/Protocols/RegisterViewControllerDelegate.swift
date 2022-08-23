//
//  RegisterViewControllerDelegate.swift
//  PhotoUs
//
//  Created by Yago Marques on 16/08/22.
//

import UIKit

protocol RegisterViewControllerDelegate: AnyObject {
    func newUser(name: String, email: String, password: String)
}
//
//  RegisterFormComponent.swift
//  PhotoUs
//
//  Created by Yago Marques on 15/08/22.
//

import UIKit

final class RegisterFormComponent: UIView {
    
    lazy var usernameTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Nome de usuário")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var emailTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Email")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var passwordTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Senha")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var createAccountButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cadastrar", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("error - RegisterFormComponent")
    }
    
}

extension RegisterFormComponent: ViewCoding {
    func setupView() {
        self.backgroundColor = .white
    }
    
    func setupConstraints() {
        let itemsSpacing = 10.0
        let verticalPadding = 35.0
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: verticalPadding),
            usernameTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            usernameTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            usernameTextField.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.15),
            
            emailTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: itemsSpacing),
            emailTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            emailTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            emailTextField.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.15),

            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: itemsSpacing),
            passwordTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            passwordTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.15),

            createAccountButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: itemsSpacing*3),
            createAccountButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            createAccountButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            createAccountButton.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.15),
            createAccountButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -verticalPadding)
        ])
    }
    
    func setupHierarchy() {
        self.addSubview(usernameTextField)
        self.addSubview(emailTextField)
        self.addSubview(passwordTextField)
        self.addSubview(createAccountButton)
    }
}

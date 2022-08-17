//
//  LoginFieldsComponent.swift
//  PhotoUs
//
//  Created by Yago Marques on 15/08/22.
//

import UIKit

final class LoginFieldsComponent: UIView {
    
    let delegate: LoginViewControllerDelegate?
    
    private lazy var loginLabel: UILabel = {
        let label = getLabel(text: "PhotoUs - Login")
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 34)
        return label
    }()
    
    private lazy var emailTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Email")
        return textField
    }()
    
    private lazy var passwordTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Senha")
        return textField
    }()
    
    private lazy var withoutAccountLabel: UILabel = {
        let label = getLabel(text: "Não possui conta?")
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Criar conta", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(toRegister), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Entrar", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        return button
    }()
    
    init(delegate: LoginViewControllerDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error - LoginFieldsComponent")
    }
    
}

private extension LoginFieldsComponent {
    private func getLabel(text: String) -> UILabel {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = text
        
        return label
    }
    
    @objc private func toRegister() {
        self.delegate?.goToRegisterView()
    }
    
    @objc private func login() {
        self.delegate?.userLogin(email: self.emailTextField.myTextField, password: self.passwordTextField.myTextField)
    }
}

extension LoginFieldsComponent: ViewCoding {
    
    func setupView() {
        self.backgroundColor = .white
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            loginLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            loginLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            loginLabel.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1),
            
            emailTextField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 10),
            emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            emailTextField.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.15),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            passwordTextField.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.15),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            loginButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            loginButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            loginButton.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.15),
            
            withoutAccountLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
            withoutAccountLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            registerButton.leadingAnchor.constraint(equalTo: withoutAccountLabel.trailingAnchor, constant: 10),
            registerButton.heightAnchor.constraint(equalTo: withoutAccountLabel.heightAnchor),
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
            
        ])
    }
    
    func setupHierarchy() {
        self.addSubview(loginLabel)
        self.addSubview(emailTextField)
        self.addSubview(passwordTextField)
        self.addSubview(loginButton)
        self.addSubview(withoutAccountLabel)
        self.addSubview(registerButton)
    }
    
}

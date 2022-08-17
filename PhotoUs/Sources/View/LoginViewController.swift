//
//  LoginViewController.swift
//  PhotoUs
//
//  Created by Yago Marques on 15/08/22.
//

import UIKit

final class LoginViewController: UIViewController {
    
    private let viewModel = LoginViewModel()
    
    private lazy var background: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "photousBackground")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var fieldsComponent: LoginFieldsComponent = {
        let component = LoginFieldsComponent(delegate: self)
        component.translatesAutoresizingMaskIntoConstraints = false
        component.clipsToBounds = true
        component.layer.cornerRadius = 30
        component.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return component
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        verifySession()
        
        buildLayout()
    }
    
}

private extension LoginViewController {
    
    private func verifySession() {
        if let _ = viewModel.trySession() {
            navigationController?.pushViewController(RegisterViewController(), animated: true)
        }
    }
    
    private func getLabel(text: String) -> UILabel {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = text
        
        return label
    }
    
}

extension LoginViewController: ViewCoding {
    func setupView() {
        view.backgroundColor = .white
        self.title = ""
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            fieldsComponent.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            fieldsComponent.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.6),
            fieldsComponent.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
    
    func setupHierarchy() {
        view.insertSubview(background, at: 0)
        view.addSubview(fieldsComponent)
    }
    
}

extension LoginViewController: LoginViewControllerDelegate {
    
    @objc func goToRegisterView() {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    @objc func userLogin(email: UITextField, password: UITextField) {
        viewModel.login(emailTextField: email, passwordTextField: password) { result in
            
        }
    }
    
}

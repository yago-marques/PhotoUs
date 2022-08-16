//
//  LoginViewController.swift
//  PhotoUs
//
//  Created by Yago Marques on 09/08/22.
//

import UIKit

final class RegisterViewController: UIViewController {
    
    private let viewModel = RegisterViewModel()
    
    private lazy var headerView: RegisterHeaderComponent = {
        let header = RegisterHeaderComponent()
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    private lazy var formView: RegisterFormComponent = {
        let form = RegisterFormComponent()
        form.translatesAutoresizingMaskIntoConstraints = false
        form.layer.cornerRadius = 10
        return form
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildLayout()
    }
    
}

private extension RegisterViewController {
    
    private func newUser(_ user: User) {

        viewModel.registerNewUser(user) { result in
            switch result {
            case let .success(session):
                print(session.token)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    
    }
    
    @objc private func backToLogin() {
        navigationController?.popViewController(animated: false)
    }
    
}

extension RegisterViewController: ViewCoding {
    
    func setupView() {
        view.backgroundColor = .secondarySystemBackground
        title = "Cadastro"
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            headerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            
            formView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -UIScreen.main.bounds.height/10),
            formView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            formView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.55),
            formView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupHierarchy() {
        view.addSubview(headerView)
        view.addSubview(formView)
    }
    
}

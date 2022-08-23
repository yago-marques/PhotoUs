//
//  LoginViewController.swift
//  PhotoUs
//
//  Created by Yago Marques on 15/08/22.
//

import UIKit

final class LoginViewController: UIViewController {
        
    private let viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Error - LoginViewController")
    }
    
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
        if let session = viewModel.trySession() {
            navigationController?.pushViewController(MainTabBarController(session: session), animated: true)
        }
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
    
    func goToRegisterView() {
        navigationController?.pushViewController(RegisterViewController(viewModel: RegisterViewModel(api: API(), delegate: viewModel)), animated: true)
    }
    
    func userLogin(email: String?, password: String?) {
        guard
            let email = email,
            let password = password,
            email != "",
            password != ""
        else {
            return
        }
        
        viewModel.login(email: email, password: password) { result in
            DispatchQueue.main.async {
                DispatchQueue.main.async {
                    switch result {
                    case let .failure(error):
                        // mostrar alerta
                        print(error)
                    case let .success(session):
                        self.navigationController?.pushViewController(MainTabBarController(session: session), animated: true)
                    }
                }
            }
        }
    }
    
}

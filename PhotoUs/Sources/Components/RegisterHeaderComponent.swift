//
//  RegisterFieldsComponent.swift
//  PhotoUs
//
//  Created by Yago Marques on 15/08/22.
//

import UIKit

final class RegisterHeaderComponent: UIView {
    
    lazy var logoImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.image = UIImage(named: "photousLogo")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    lazy var registerLabel: UILabel = {
        let label = getLabel(text: "Seja bem vindo(a)! Preencha os campos abaixo para criar sua conta")
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    lazy var headerView: UIView = {
        let header = UIView(frame: .zero)
        header.translatesAutoresizingMaskIntoConstraints = false
        header.backgroundColor = .black
        return header
    }()
    
    init() {
        super.init(frame: .zero)
        
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("error - RegisterFieldsComponent")
    }
    
}

private extension RegisterHeaderComponent {
    private func getLabel(text: String) -> UILabel {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = text
    
        return label
    }

}

extension RegisterHeaderComponent: ViewCoding {
    func setupView() {
        self.backgroundColor = .secondarySystemBackground
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: self.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            headerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            logoImage.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            logoImage.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 60),
            logoImage.heightAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 0.2),
            logoImage.widthAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 0.2),
            
            registerLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 15),
            registerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            registerLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
        ])
    }
    
    func setupHierarchy() {
        headerView.addSubview(logoImage)
        headerView.addSubview(registerLabel)
        self.addSubview(headerView)
    }
}

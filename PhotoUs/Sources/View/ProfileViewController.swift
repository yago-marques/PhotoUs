//
//  ProfileViewController.swift
//  PhotoUs
//
//  Created by Yago Marques on 18/08/22.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    weak var delegate: MainTabBarControllerDelegate?
    
    init(delegate: MainTabBarControllerDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error - ProfileViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.delegate?.setTitle(newTitle: "Conta")
    }
    
}

extension ProfileViewController: ViewCoding {
    func setupView() {
        view.backgroundColor = .systemGray4
        self.delegate?.setTitle(newTitle: "Conta")
    }
    
    func setupConstraints() {
        
    }
    
    func setupHierarchy() {
        
    }
    
    
}

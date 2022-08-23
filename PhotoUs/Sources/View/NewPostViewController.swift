//
//  NewPostViewController.swift
//  PhotoUs
//
//  Created by Yago Marques on 18/08/22.
//

import UIKit

final class NewPostViewController: UIViewController {
    
    weak var delegate: MainTabBarControllerDelegate?
    
    init(delegate: MainTabBarControllerDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error - NewPostViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.delegate?.setTitle(newTitle: "Novo Post")
    }
    
}

extension NewPostViewController: ViewCoding {
    func setupView() {
        view.backgroundColor = .systemGray3
    }
    
    func setupConstraints() {
        
    }
    
    func setupHierarchy() {
        
    }
    
    
}

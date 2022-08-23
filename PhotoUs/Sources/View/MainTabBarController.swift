//
//  MainTabBarController.swift
//  PhotoUs
//
//  Created by Yago Marques on 18/08/22.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    private let session: UserSession
    
    private lazy var tabViews: [UIViewController] = {
        let tabOne = PostsViewController(delegate: self, viewModel: PostViewModel(api: API(), session: session))
        let tabTwo = NewPostViewController(delegate: self)
        let tabThree = ProfileViewController(delegate: self)
        
        return [tabOne, tabTwo, tabThree]
    }()
    
    
    init(session: UserSession) {
        self.session = session
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Error - MainTabBarController")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        buildLayout()
    }
    
}

extension MainTabBarController: UITabBarControllerDelegate { }

private extension MainTabBarController {
    private func configureTabs() {
        let postsTabBarItem = UITabBarItem(title: "Posts", image: UIImage(systemName: "rectangle.stack"), selectedImage: UIImage(systemName: "rectangle.stack.fill"))
        tabViews[0].tabBarItem = postsTabBarItem
        
        let newPostTabBarItem = UITabBarItem(title: "Novo post", image: UIImage(systemName: "plus.circle"), selectedImage: UIImage(systemName: "plus.circle.fill"))
        tabViews[1].tabBarItem = newPostTabBarItem
        
        let profileTabBarItem = UITabBarItem(title: "Conta", image: UIImage(systemName: "person.circle"), selectedImage: UIImage(systemName: "person.circle.fill"))
        tabViews[2].tabBarItem = profileTabBarItem
    }
}

extension MainTabBarController: ViewCoding {
    func setupView() {
        self.navigationItem.hidesBackButton = true
        self.tabBar.backgroundColor = .systemGroupedBackground
        self.delegate = self
        configureTabs()
    }
    
    func setupConstraints() { }
    
    func setupHierarchy() {
        
        self.viewControllers = tabViews
    }
}

extension MainTabBarController: MainTabBarControllerDelegate {
    func setTitle(newTitle: String) {
        self.title = newTitle
    }
}

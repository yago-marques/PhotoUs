//
//  PostsViewController.swift
//  PhotoUs
//
//  Created by Yago Marques on 17/08/22.
//

import UIKit

final class PostsViewController: UIViewController {
    
    private var viewModel: PostViewModel
    weak var delegate: MainTabBarControllerDelegate?
    
    init(delegate: MainTabBarControllerDelegate, viewModel: PostViewModel) {
        self.delegate = delegate
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error - PostsViewController")
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let height = view.safeAreaLayoutGuide.layoutFrame.height - (tabBarController?.tabBar.frame.height)!
        layout.itemSize = CGSize(width: view.frame.width, height: height)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let myCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        myCollectionView.register(TextPostCell.self, forCellWithReuseIdentifier: AppIdentifiers.textPostCell)
        myCollectionView.backgroundColor = .systemGray5
        myCollectionView.isPagingEnabled = true
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        myCollectionView.showsHorizontalScrollIndicator = false
        
        return myCollectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task.detached {
            await self.fetchPosts()
        }
        
        self.delegate?.setTitle(newTitle: "Posts")
    }
    
}

private extension PostsViewController {
    private func fetchPosts() async {
        await viewModel.fetchPosts()
    }
}

extension PostsViewController: PostsViewControllerDelegate {
    func updateCollection() {
        collectionView.reloadData()
    }
}

extension PostsViewController: ViewCoding {
    func setupView() {
        view.backgroundColor = .systemGroupedBackground
        viewModel.delegate = self
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor)
        ])
    }
    
    func setupHierarchy() {
        view.addSubview(collectionView)
    }
    
}

extension PostsViewController: UICollectionViewDelegate { }

extension PostsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: AppIdentifiers.textPostCell, for: indexPath) as? TextPostCell else {
            return UICollectionViewCell(frame: .zero)
        }
        
        let post = viewModel.posts[indexPath.row]
        myCell.post = post
        
        return myCell
    }
    
}

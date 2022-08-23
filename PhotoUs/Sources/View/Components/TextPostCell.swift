//
//  TextPostCell.swift
//  PhotoUs
//
//  Created by Yago Marques on 22/08/22.
//

import UIKit

final class TextPostCell: UICollectionViewCell {
    
    var post: Post = Post(id: "Unknow", content: "Unknow", media: nil, likeCount: 0, author: "Unknow", createdAt: "Unknow", updatedAt: "Unknow") {
        didSet {
            messageTextView.text = post.content
            authorLabel.text = post.author
        }
    }
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = post.author
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        return label
    }()
    
    private lazy var defaultUserAvatar: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "person.fill")
        image.tintColor = .systemBlue
        
        return image
    }()
    
    private lazy var headerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var avatarImage: UIView = {
        let view = UIView(frame: .zero)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGroupedBackground
        
        return view
    }()
    
    private lazy var postBackground: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        view.layer.opacity = 0.5
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private lazy var messageTextView: UITextView = {
        let text = UITextView(frame: .zero)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = post.content
        text.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        text.backgroundColor = UIColor.clear
        text.textAlignment = .center
        text.isEditable = false
        
        return text
    }()
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error - TextPostCell")
    }
    
}

extension TextPostCell: ViewCoding {
    func setupView() {
        self.backgroundColor = .random()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            scrollView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            scrollView.widthAnchor.constraint(equalTo: self.widthAnchor),
            scrollView.heightAnchor.constraint(equalTo: self.heightAnchor),
            
            postBackground.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            postBackground.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            postBackground.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            postBackground.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),
            
            headerView.topAnchor.constraint(equalTo: postBackground.topAnchor, constant: 20),
            headerView.widthAnchor.constraint(equalTo: postBackground.widthAnchor, multiplier: 0.7),
            headerView.centerXAnchor.constraint(equalTo: postBackground.centerXAnchor),
            headerView.heightAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.25),
            
            avatarImage.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            avatarImage.heightAnchor.constraint(equalTo: headerView.heightAnchor),
            avatarImage.widthAnchor.constraint(equalTo: avatarImage.heightAnchor),
            avatarImage.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            defaultUserAvatar.heightAnchor.constraint(equalTo: avatarImage.heightAnchor, multiplier: 0.8),
            defaultUserAvatar.widthAnchor.constraint(equalTo: defaultUserAvatar.heightAnchor),
            defaultUserAvatar.centerYAnchor.constraint(equalTo: avatarImage.centerYAnchor),
            defaultUserAvatar.centerXAnchor.constraint(equalTo: avatarImage.centerXAnchor),
            
            authorLabel.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.8),
            authorLabel.topAnchor.constraint(equalTo: headerView.topAnchor),
            authorLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            authorLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            
            messageTextView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 30),
            messageTextView.centerXAnchor.constraint(equalTo: postBackground.centerXAnchor),
            messageTextView.widthAnchor.constraint(equalTo: postBackground.widthAnchor, multiplier: 0.8),
            messageTextView.heightAnchor.constraint(equalTo: postBackground.heightAnchor, multiplier: 0.5),
        ])
    }
    
    func setupHierarchy() {
        self.addSubview(scrollView)
        scrollView.addSubview(postBackground)
        scrollView.addSubview(messageTextView)
        scrollView.addSubview(headerView)
        headerView.addSubview(avatarImage)
        headerView.addSubview(defaultUserAvatar)
        headerView.addSubview(authorLabel)
    }
    
    
}

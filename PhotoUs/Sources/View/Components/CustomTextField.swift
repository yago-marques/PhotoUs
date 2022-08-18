//
//  CustomTextField.swift
//  PhotoUs
//
//  Created by Yago Marques on 15/08/22.
//

import UIKit

final class CustomTextField: UIView {
    
    private var placeholder: String
    private var lineColor: UIColor
    private var lineWidth: Double
    
    lazy var myTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(
            string: self.placeholder,
            attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray]
        )
        
        return textField
    }()
    
    private lazy var textFieldLine: UIView = {
        let line = UIView(frame: .zero)
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = self.lineColor
        
        return line
    }()
    
    init(placeholder: String, lineColor: UIColor = .black, lineWidth: Double = 1) {
        self.placeholder = placeholder
        self.lineColor = lineColor
        self.lineWidth = lineWidth
        super.init(frame: .zero)
        
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error - CustomTextField")
    }
    
}

extension CustomTextField: ViewCoding {
    func setupView() {
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            myTextField.topAnchor.constraint(equalTo: self.topAnchor),
            myTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -lineWidth),
            myTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            myTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            textFieldLine.topAnchor.constraint(equalTo: myTextField.bottomAnchor),
            textFieldLine.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            textFieldLine.trailingAnchor.constraint(equalTo: myTextField.trailingAnchor),
            textFieldLine.leadingAnchor.constraint(equalTo: myTextField.leadingAnchor),
        ])
    }
    
    func setupHierarchy() {
        self.addSubview(myTextField)
        self.addSubview(textFieldLine)
    }
    
    
}

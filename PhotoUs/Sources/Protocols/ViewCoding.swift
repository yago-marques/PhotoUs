//
//  ViewCoding.swift
//  PhotoUs
//
//  Created by Yago Marques on 10/08/22.
//

import Foundation

protocol ViewCoding {
    func setupView() -> Void
    func setupConstraints() -> Void
    func setupHierarchy() -> Void
}

extension ViewCoding {
    func buildLayout() {
        setupView()
        setupConstraints()
        setupHierarchy()
    }
}

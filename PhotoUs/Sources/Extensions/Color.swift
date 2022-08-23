//
//  Color.swift
//  PhotoUs
//
//  Created by Yago Marques on 22/08/22.
//

import UIKit

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}

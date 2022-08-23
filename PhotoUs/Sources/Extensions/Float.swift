//
//  Float.swift
//  PhotoUs
//
//  Created by Yago Marques on 22/08/22.
//

import UIKit

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

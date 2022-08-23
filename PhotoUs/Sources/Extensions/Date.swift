//
//  Date.swift
//  PhotoUs
//
//  Created by Yago Marques on 23/08/22.
//

import Foundation

extension Date {
    func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}

//
//  KeychainEnums.swift
//  PhotoUs
//
//  Created by Yago Marques on 12/08/22.
//

import Foundation

enum KeychainError: Error {
    case itemNotFound
    case duplicateItem
    case invalidItemFormat
    case unexpectedStatus(OSStatus)
}

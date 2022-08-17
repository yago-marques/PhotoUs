//
//  Keychain.swift
//  PhotoUs
//
//  Created by Lunes on 16/08/22.
//

import UIKit

class Keychain {
    
    static func save(token: Data, service: String, account: String) throws {
        let query: [String:AnyObject] = [
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecClass as String: kSecClassGenericPassword,
            kSecValueData as String: token as AnyObject
            
        ]
        let status = SecItemAdd(query as CFDictionary,nil)
        
        if status == errSecDuplicateItem {
            throw KeychainError.duplicateItem
        }
        
        guard status == errSecSuccess else {
            throw KeychainError.unexpectedStatus(status)
            
            
        }
        
    }
    static func read (service: String, account : String) throws -> Data{
        let query: [String: AnyObject] = [
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecClass as String: kSecClassGenericPassword,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String:kCFBooleanTrue
            
        ]
        var itemCopy: AnyObject?
        let status = SecItemCopyMatching(
            query as CFDictionary,
            &itemCopy
            
        )
        guard status != errSecItemNotFound else {
            throw KeychainError.itemNotFound
            
            
        }
        
        guard status == errSecSuccess else {
            throw KeychainError.unexpectedStatus(status)
            
        }
        
        guard let token = itemCopy as? Data else {
            throw KeychainError.invalidItemFormat
            
        }
        
        return token
        
    }
    
}
enum KeychainError: Error{
    case itemNotFound
    case duplicateItem
    case invalidItemFormat
    case unexpectedStatus(OSStatus)
    
}



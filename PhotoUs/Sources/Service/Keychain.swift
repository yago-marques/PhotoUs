//
//  Keychain.swift
//  PhotoUs
//
//  Created by Yago Marques on 12/08/22.
//

import Foundation

final class Keychain {
        
    static func create(session: Data, service: String, account: String) throws {
        
        if Keychain.hasSession() {
            
            do {
                try Keychain.update(token: session, service: service, account: account)
            } catch {
                print(error)
            }
            
        } else {
            
            let query: [String: AnyObject] = [
                kSecAttrService as String: service as AnyObject,
                kSecAttrAccount as String: account as AnyObject,
                kSecClass as String: kSecClassGenericPassword,
                kSecValueData as String: session as AnyObject,
            ]
            
            let status = SecItemAdd(query as CFDictionary, nil)
            
            if status == errSecDuplicateItem {
                throw KeychainError.duplicateItem
            }
            
            guard status == errSecSuccess else {
                throw KeychainError.unexpectedStatus(status)
            }
            
        }
        
    }
        
    static func read(service: String, account: String) throws -> UserSession? {
        let query: [String: AnyObject] = [
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecClass as String: kSecClassGenericPassword,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: kCFBooleanTrue
        ]

        var itemCopy: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &itemCopy)

        guard status != errSecItemNotFound else {
            throw KeychainError.itemNotFound
        }
        
        guard status == errSecSuccess else {
            throw KeychainError.unexpectedStatus(status)
        }

        guard let session = itemCopy as? Data else {
            throw KeychainError.invalidItemFormat
        }
        
        let userSession = try? JSONDecoder().decode(UserSession.self, from: session)

        return userSession
    }
    
    static func update(token: Data, service: String, account: String) throws {
        let query: [String: AnyObject] = [
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecClass as String: kSecClassGenericPassword
        ]
        
        let attributes: [String: AnyObject] = [
            kSecValueData as String: token as AnyObject
        ]
        
        let status = SecItemUpdate(
            query as CFDictionary,
            attributes as CFDictionary
        )

        guard status != errSecItemNotFound else {
            throw KeychainError.itemNotFound
        }

        guard status == errSecSuccess else {
            throw KeychainError.unexpectedStatus(status)
        }
    }
    
    static func delete(service: String, account: String) throws {
        
        let query: [String: AnyObject] = [
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecClass as String: kSecClassGenericPassword
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        guard status == errSecSuccess else {
            throw KeychainError.unexpectedStatus(status)
        }
        
    }
    
    static func hasSession() -> Bool {
        do {
            let _ = try Keychain.read(service: AppIdentifiers.bundleID, account: AppIdentifiers.bundleID)
            
            return true
        } catch {
            print(error)
        }
        
        return false
    }
    
    static func guardSession(_ session: UserSession) {
        
        guard let userSession = try? JSONEncoder().encode(session) else { return }
        
        do {
            try Keychain.create(
                session: userSession,
                service: AppIdentifiers.bundleID,
                account: AppIdentifiers.bundleID
            )
        } catch {
            print(error)
        }
    }
    
}

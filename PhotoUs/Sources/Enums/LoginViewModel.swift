//
//  LoginViewModel.swift
//  PhotoUs
//
//  Created by Yago Marques on 12/08/22.
//

import Foundation

final class LoginViewModel {
    
    func trySession() -> UserSession? {
        
        if Keychain.hasSession() {
            do {
                let session = try Keychain.read(service: AppIdentifiers.bundleID, account: AppIdentifiers.bundleID)
                
                return session
            } catch {
                print(error)
            }
        }
        
        return nil
    }
    
}

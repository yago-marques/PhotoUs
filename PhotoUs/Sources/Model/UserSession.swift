//
//  UserSession.swift
//  PhotoUs
//
//  Created by Yago Marques on 10/08/22.
//

import Foundation

struct UserFromSession: Codable {
    let id: String
    let name: String
    let email: String
    let avatar: String?
}

struct UserSession: Codable {
    var token: String
    let user: UserFromSession
}

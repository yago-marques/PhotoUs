//
//  userSession.swift
//  PhotoUs
//
//  Created by Lunes on 10/08/22.
//

import Foundation

struct UserSession: Decodable {
    var token: String
    var user: UserFromSession
}

struct UserFromSession: Decodable {
    var id: String
    var name: String
    var email: String
    var avatar: String?
}

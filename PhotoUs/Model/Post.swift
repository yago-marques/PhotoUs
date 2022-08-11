//
//  Post.swift
//  PhotoUs
//
//  Created by Yago Marques on 11/08/22.
//

import Foundation

struct Post: Decodable {
    let id: String
    let content: String
    let media: String?
    let like_count: Int
    let user_id: String
    let created_at: String
    let updated_at: String
}

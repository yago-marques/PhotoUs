//
//  Post.swift
//  PhotoUs
//
//  Created by Yago Marques on 22/08/22.
//

import Foundation

struct Post: Codable {
    let id: String
    let content: String
    let media: String?
    let likeCount: Int
    var author: String
    var createdAt: String
    var updatedAt: String
    
    enum CodingKeys : String, CodingKey {
        case id, content, media
        case likeCount = "like_count"
        case author = "user_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

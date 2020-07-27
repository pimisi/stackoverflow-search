//
//  User.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import Foundation

struct User: Codable {
    
    let userID: Int
    let userType: String
    let displayName: String
    let profileImageURL: String?
    let link: String?
    let reputation: Int
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case userType = "user_type"
        case displayName = "display_name"
        case profileImageURL = "profile_image"
        case link, reputation
    }
}

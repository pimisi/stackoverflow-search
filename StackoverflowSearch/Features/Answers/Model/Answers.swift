//
//  Answers.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import Foundation

class Answers: Codable {
    let items: [Answer]
    let hasMore: Bool
    
    enum CodingKeys: String, CodingKey {
        case items
        case hasMore = "has_more"
    }
    
    enum Sort: String {
        case active = "activity", oldest = "creation", votes, none
        
        init?(index: Int) {
            switch index {
            case 0: self = .active
            case 1: self = .oldest
            case 2: self = .votes
            default: self = .none
            }
        }
        
        var index: Int? {
            switch self {
            case .active: return 0
            case .oldest: return 1
            case .votes: return 2
            default: return nil
            }
        }
    }
    
    enum Order: String {
        case desc, asc
    }
}

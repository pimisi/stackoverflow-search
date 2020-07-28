//
//  SearchResult.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import Foundation

class SearchResult : Codable {
    let questions: [Question]
    let hasMore: Bool

    enum CodingKeys: String, CodingKey {
        case questions = "items"
        case hasMore = "has_more"
    }
}

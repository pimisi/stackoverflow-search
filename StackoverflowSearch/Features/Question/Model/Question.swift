//
//  Question.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import Foundation

class Question: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "question_id"
        case owner, title, body
        case tags
        case isAnswered = "is_answered"
        case viewCount = "view_count"
        case answerCount = "answer_count"
        case votes = "score"
        case dateCreated = "creation_date"
        case lastEditDate = "last_edit_date"
        case lastActivityDate = "last_activity_date"
    }
    
    var id: Int
    var owner: User
    var title: String
    var body: String
    let tags: [String]?
    var isAnswered: Bool
    var viewCount: Int
    var answerCount: Int
    var votes: Int
    var dateCreated: Date
    var lastEditDate: Date?
    var lastActivityDate: Date?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Question.CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.owner = try container.decode(User.self, forKey: .owner)
        self.title = try container.decode(String.self, forKey: .title)
        self.body = try container.decode(String.self, forKey: .body)
        self.tags = try? container.decodeIfPresent([String].self, forKey: .tags)
        self.isAnswered = try container.decode(Bool.self, forKey: .isAnswered)
        self.viewCount = try container.decode(Int.self, forKey: .viewCount)
        self.answerCount = try container.decode(Int.self, forKey: .answerCount)
        self.votes = try container.decode(Int.self, forKey: .votes)
        
        let timestamp = try container.decode(Int.self, forKey: .dateCreated)
        self.dateCreated = Date(withUTC: Int64(timestamp))
        
        if let lastEditTimestamp = try container.decodeIfPresent(Int.self, forKey: .lastEditDate) {
            self.lastEditDate = Date(withUTC: Int64(lastEditTimestamp))
        } else {
            self.lastEditDate = nil
        }
        
        if let lastActivityTimestamp = try container.decodeIfPresent(Int.self, forKey: .lastActivityDate) {
            self.lastActivityDate = Date(withUTC: Int64(lastActivityTimestamp))
        } else {
            self.lastActivityDate = nil
        }
    }
}

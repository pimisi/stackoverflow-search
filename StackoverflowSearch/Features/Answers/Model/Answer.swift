//
//  Answer.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import Foundation

class Answer: Codable {
    
    let owner: User
    let answerID: Int
    let questionID: Int
    let body: String
    let isAccepted: Bool
    let score: Int
    let dateCreated: Date
    let dateOfLastActivity: Date
    let dateLastEdited: Date?

    enum CodingKeys: String, CodingKey {
        case owner
        case answerID = "answer_id"
        case questionID = "question_id"
        case body
        case score
        case isAccepted = "is_accepted"
        case dateCreated = "creation_date"
        case dateOfLastActivity = "last_activity_date"
        case dateLastEdited = "last_edit_date"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Answer.CodingKeys.self)
        
        self.owner = try container.decode(User.self, forKey: .owner)
        self.questionID = try container.decode(Int.self, forKey: .questionID)
        self.answerID = try container.decode(Int.self, forKey: .answerID)
        self.body = try container.decode(String.self, forKey: .body)
        self.isAccepted = try container.decode(Bool.self, forKey: .isAccepted)
        self.score = try container.decode(Int.self, forKey: .score)
        
        let dateCreatedTimestamp = try container.decode(Int.self, forKey: .dateCreated)
        self.dateCreated = Date(withUTC: Int64(dateCreatedTimestamp))
        
        let dateOfLastActivityTimestamp = try container.decode(Int.self, forKey: .dateOfLastActivity)
        self.dateOfLastActivity = Date(withUTC: Int64(dateOfLastActivityTimestamp))
        
        if let dateLastEditedTimestamp = try container.decodeIfPresent(Int.self, forKey: .dateLastEdited) {
            self.dateLastEdited = Date(withUTC: Int64(dateLastEditedTimestamp))
        } else {
             self.dateLastEdited = nil
        }
    }
}

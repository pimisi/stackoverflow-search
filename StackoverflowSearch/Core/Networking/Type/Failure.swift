//
//  Failure.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import Foundation

struct Failure: Error {
    private var message: Any?
    
    var error: FailureReason?
    var title: String?
    
    init(error: Error?, title: String? = nil, message: AnyObject? = nil) {
        self.error = FailureReason(error: error)
        self.title = title
        self.message = message ?? self.error?.message
    }
    
    var description: String {
        if let messageObject = message as? Array<Dictionary<String, Any>>, let key = messageObject.first?.keys.first, key.lowercased() == "message", let message = messageObject.first?[key] as? String {
            return message
        } else if let message = message as? String {
            return message
        } else {
            return error?.message ?? FailureReason.unknown.message!
        }
    }
    
    var code: Int {
        return error?.code ?? 1
    }
}

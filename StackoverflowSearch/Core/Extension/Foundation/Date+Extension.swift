//
//  Date+Extension.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import Foundation

extension Date {
        
    init(withUTC timestamp: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(timestamp))
    }
    
    func asString(withFormat format: String) -> String {
        let formatter = DateFormatter.baseFormatter
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    var asString: String {
        return self.asString(withFormat: "yyyy-MM-dd'T'HH:mm:ssZ")
    }
}

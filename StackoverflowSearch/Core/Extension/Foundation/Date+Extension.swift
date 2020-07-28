//
//  Date+Extension.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import Foundation

extension Date {
        
    static var gregorianCalendar = Calendar(identifier: .gregorian)
    
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
    
    func timeBeforeNow(suffix: String = String()) -> String {
        let components = Date.gregorianCalendar.dateComponents([.year, .month, .weekOfYear, .hour, .minute, .second], from: self, to: Date())
        
        let years = components.year ?? 0
        let months = components.month ?? 0
        let weeks = components.weekOfYear ?? 0
        let days = components.day ?? 0
        let hours = components.hour ?? 0
        let minutes = components.minute ?? 0
        let seconds = components.second ?? 0
        
        var string: String;
        
        if years > 0 {
            string = plural(for: years, suffix: "year")
        } else if months > 0 {
            string = plural(for: months, suffix: "month")
        } else if weeks > 0 {
            string = plural(for: weeks, suffix: "week")
        } else if days > 0 {
            string = plural(for: days, suffix: "day")
        } else if hours > 0 {
            string = plural(for: hours, suffix: "hour")
        } else if minutes > 0 {
            string = plural(for: minutes, suffix: "minute")
        } else {
            string = plural(for: seconds, suffix: "second")
        }
        
        return "\(string)\(!suffix.isEmpty ? " " : "")\(suffix)"
    }
    
    private func plural(for count: Int, suffix: String) -> String {
        return "\(count) \(suffix)\(count > 1 ? "s" : "")"
    }
}

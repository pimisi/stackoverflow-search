//
//  DateFormatter+Extension.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static var baseFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_ZA")
        formatter.timeZone = .current
        
        return formatter
    }
    
    static var shortDateFormat: String {
        return "MMM d ''yy"
    }
    
    static var mediumDateFormat: String {
        return "MMM d yyyy"
    }
    
    static var twentyFourHourTimeFormat: String {
        return "HH:mm"
    }
}

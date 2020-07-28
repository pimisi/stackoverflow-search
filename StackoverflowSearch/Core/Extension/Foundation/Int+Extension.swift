//
//  Int+Extension.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import Foundation

extension Int {
    
    var shortenedStringFormatted: String {
        
        var string = ""
        
        if (self > 1000) {
            string = "\(self/1000)k"
        } else if (self > 1000000) {
            string = "\(self/1000000)m"
        } else {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            string = self.formatted
        }
        
        return string
    }
    
    var formatted: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}

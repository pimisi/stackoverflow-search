//
//  String+Extension.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import UIKit

extension String {
    
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var attributtedStringFromHTML: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        
        do {
            let attributtedString = NSMutableAttributedString()
            let string = try NSAttributedString(data: data, options: [.documentType : NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            
            attributtedString.append(string)
            let range = NSMakeRange(0, string.length)
            attributtedString.addAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0)], range: range)
            
            return attributtedString
        } catch let exception {
            debugLog("Error converting HTML string to attributed string: \(exception.localizedDescription)")
            return nil
        }
    }
    
    var stripHTMLTags: String {
        return attributtedStringFromHTML?.string ?? ""
    }
}

//
//  NSAttributedString+Extension.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import UIKit

extension NSAttributedString {
    static func attributtedString(for value: String, prefix: String? = nil, valueColor: UIColor = UIColor.black, prefixColor: UIColor = UIColor.lightGray, fontSize: CGFloat = 12.0) -> NSAttributedString {
        let attributtedString = NSMutableAttributedString(string: prefix ?? "",
                                                          attributes: [
                                                            NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize),
                                                            NSAttributedString.Key.foregroundColor: prefixColor
        ])
        
        attributtedString.append(
            NSAttributedString(string: value,
                attributes: [
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize),
                    NSAttributedString.Key.foregroundColor: valueColor
            ]))
        
        return attributtedString
    }
}

extension NSMutableAttributedString {
    
    public func appendImage(_ image: UIImage) {
        
        let attachment: NSTextAttachment
        attachment = NSTextAttachment()
        attachment.image = image
        
        let imageString = NSAttributedString(attachment: attachment)
        
        self.append(imageString)
    }
    
    public func addWordSpacing(_ count: Int) {
        for _ in 0..<count {
            append(NSAttributedString(string: " "))
        }
    }
}

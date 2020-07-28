//
//  UIMessage.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import Foundation

extension Constant {
    class UIMessage: NSObject {
        var title: String
        var detail: String
        var buttonTitle: String
        
        init(title: String, detail: String, buttonTitle: String? = nil) {
            self.title = title
            self.detail = detail
            self.buttonTitle = buttonTitle ?? ""
        }
    }
}

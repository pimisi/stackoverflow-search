//
//  Error+Extension.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import Foundation

extension Error {
    
    private var this: NSError {
        return self as NSError
    }
    var code: Int {
        return this.code
    }
    
    var domain: String {
        return this.domain
    }
    
    var userInfo: Dictionary<String, Any> {
        return this.userInfo
    }
    
    var description: String {
        return (userInfo[NSLocalizedDescriptionKey] as? String) ?? String()
    }
}

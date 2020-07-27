//
//  String+Extension.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import Foundation

extension String {
    
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

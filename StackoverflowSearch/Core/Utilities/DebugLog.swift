//
//  DebugLog.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import Foundation

func debugLog(_ message: String) {
    #if DEBUG
        print(message)
    #endif
}

func debugLog(_ className: String, message: String) {
    #if DEBUG
        print(className + " | " + message)
    #endif
}

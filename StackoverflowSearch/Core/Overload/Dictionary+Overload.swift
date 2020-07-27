//
//  Dictionary+Overload.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import Foundation

public func + <KeyType, ValueType> (left: Dictionary<KeyType, ValueType>, right: Dictionary<KeyType, ValueType>) -> Dictionary<KeyType, ValueType> {
    
    var _left = left
    
    for (key, value) in right {
        _left.updateValue(value, forKey: key)
    }
    
    return _left
}

//
//  Dictionary+Extension.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import Foundation

extension Dictionary where Key == AnyHashable {

    func object(forKey key: String) -> Any? {
        if key.contains("|") {
            let parts = key.split(separator: "|").map { String($0).trimmed }
            
            for part in parts {
                if let value = object(forKey: part) {
                    return value
                }
            }
        }
        return self[key]
    }
    
    func int(forKey key: String) -> Int {
        if let string = object(forKey: key) as? String {
            return Int(string) ?? 0
        }
        
        return object(forKey: key) as? Int ?? 0
    }
    
    func intOrNil(forKey key: String) -> Int? {
        if let string = object(forKey: key) as? String {
            return Int(string)
        }
        
        return object(forKey: key) as? Int
    }
    
    func string(forKey key: String) -> String {
        return object(forKey: key) as? String ?? ""
    }
    
    func stringOrNil(forKey key: String) -> String? {
        return object(forKey: key) as? String
    }
}

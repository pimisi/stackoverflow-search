//
//  Data+Extension.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import Foundation

extension Data {
    private func object(with data: Data, options opt: JSONSerialization.ReadingOptions = []) -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: self, options: JSONSerialization.ReadingOptions())
        } catch {
            print("Could not serialize data. \(error): \(#function)")
            return nil
        }
    }
    
    var dictionary: GenericDictionary? {
        return object(with: self) as? GenericDictionary
    }
}

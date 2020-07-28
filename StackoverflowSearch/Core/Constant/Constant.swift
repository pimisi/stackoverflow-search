//
//  Constant.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import Foundation

public class ConstantType: NSObject {
    fileprivate override init() {}
}

public class Constant: ConstantType {
    
    static let infoDictionary = Bundle.main.infoDictionary
    
    static var appVersionString: String? {
        let version = infoDictionary?["CFBundleShortVersionString"] as? String
        
        return version
    }
}

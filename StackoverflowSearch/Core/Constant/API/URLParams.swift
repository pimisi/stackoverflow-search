//
//  URLParams.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import Foundation

typealias URLParams = Constant.API.URLParams

extension Constant.API {
    
    class URLParams: ConstantType {
        class Key: ConstantType {
            static let filter = "filter"
            static let order = "order"
            static let pageSize = "pagesize"
            static let site = "site"
            static let sort = "sort"
            static let title = "title"
        }
    }
}

//
//  URLSessionConfiguration+Extension.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import Foundation

extension URLSessionConfiguration {
    static var defaultHeaders: Dictionary<String, String> {
        return Constant.API.Headers.ContentType.json + Constant.API.Headers.Accept.json
    }
}


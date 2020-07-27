//
//  APIOption.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import Foundation

public struct APIOption {
    /// The expected status code for the service call, defaults to allowing any.
    var expectedStatusCode: Int?
    
    /// An optional set of HTTP Headers to send with the call.
    var httpHeaders: [String : String]?
    
    /// Accepted types for the service call
    var acceptHeader = Constant.API.Headers.Accept.value.json
    
    /// The amount of time in `seconds` until the request times out.
    var requestTimeoutInSeconds: TimeInterval = 120.0
    
    /// The method to use when makgin the call
    var method: HTTPMethod?
}

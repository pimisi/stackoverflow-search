//
//  URLRequest+Extension.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import Foundation

extension URLRequest {
    init(url: URL, params: StringDictionary? = nil, method: HTTPMethod, options: APIOption? = nil, body: Data? = nil) {
        
        var requestUrl: URL;
        
        if let params = params {
            let queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
            components.queryItems = queryItems
            
            requestUrl = components.url!
        } else {
            requestUrl = url
        }
        
        self.init(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: options?.requestTimeoutInSeconds ?? 60.0)
        httpMethod = method.asString
        
        let headers = options?.httpHeaders ?? [:].merging(URLSessionConfiguration.defaultHeaders) { $1 }
        
        for (header, value) in headers {
            setValue(value, forHTTPHeaderField: header)
        }
        
        httpBody = body
    }
}

//
//  APIClientProtocol.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import Foundation

protocol APIClientProtocol {
    var options: APIOption { get set }
    var defaultHeaders: Dictionary<AnyHashable, String> { get }
    
    static func client(withURL url: String) -> APIClientProtocol?
}

//
//  APIClientDataProtocol.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import Foundation

protocol APIClientDataProtocol: APIClientProtocol {
    func getData(from relativePath: String?, urlParams params: StringDictionary?, options: APIOption?, callback: @escaping (Any?, Error?, HTTPURLResponse?) -> Void)
    
    // TODO: Declare POST method
}

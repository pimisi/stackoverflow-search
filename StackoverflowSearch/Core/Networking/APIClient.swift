//
//  APIClient.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import Foundation

class APIClient: APIClientDataProtocol {
    
    let url: URL
    
    private var session: URLSession
    
    var options: APIOption = APIOption()
    
    var defaultHeaders: Dictionary<AnyHashable, String> {
        return Constant.API.Headers.ContentType.json
    }
    
    private init(withURL url: URL) {
        self.url = url
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = URLSessionConfiguration.defaultHeaders
        
        self.session = URLSession(configuration: configuration)
    }
    
    private static func prepare(urlString: String) -> APIClientDataProtocol? {
        if let url = URL(string: urlString.trimmingCharacters(in: CharacterSet.whitespaces)) {
            return APIClient(withURL: url)
        }
        return nil
    }
    
    static func client(withURL url: String) -> APIClientProtocol? {
        return APIClient.prepare(urlString: url)
    }
    
    func dataTask(relativePath path: String?, options: APIOption?, urParams params: StringDictionary? = nil, completion: @escaping (Data?, Error?, HTTPURLResponse?) -> Void) {
        
        let url: URL
        let options = options ?? APIOption()
        
        if let path = path {
            url = self.url.appendingPathComponent(path)
        } else {
            url = self.url
        }
        
        let request = URLRequest(url: url, params: params, method: options.method ?? .get, options: options)
        
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error, response as? HTTPURLResponse)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, nil, response as? HTTPURLResponse)
                return
            }
            
            if let expectedStatusCode = options.expectedStatusCode, httpResponse.statusCode != expectedStatusCode {
                
                var userInfoValue: String?
                var errorCode: Int?
                
                if let data = data {
                    let dictionary = data.dictionary
                    errorCode = dictionary?.intOrNil(forKey: "error_id")
                    userInfoValue = dictionary?.stringOrNil(forKey: "error_message")
                }
                
                let error = NSError(domain: Constant.API.errorDomain, code: errorCode ?? httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: userInfoValue ?? "Error: could not match expected status code."])
                
                debugLog(String(describing: Self.self), message: "\(#function) failure with result: \(String(describing: data?.dictionary))")
                completion(nil, error, httpResponse)
                return
            }
            
            guard let responseData = data else {
                let error = NSError(domain: Constant.API.errorDomain, code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Data length is zero"])
                completion(nil, error, httpResponse)
                return
            }
            
            completion(responseData, nil, httpResponse)
        }.resume()
    }
    
    func getData(from relativePath: String?, urlParams params: StringDictionary? = nil, options: APIOption? = nil, callback: @escaping (Any?, Error?, HTTPURLResponse?) -> Void) {
        
        var mutableOptions = options ?? APIOption()
        mutableOptions.method = .get
        mutableOptions.expectedStatusCode = mutableOptions.expectedStatusCode ?? 200
        
        dataTask(relativePath: relativePath, options: mutableOptions, urParams: params) { data, error, response in
            callback(data, error, response)
        }
    }
    
    // TODO: Add method for making POST calls
}

//
//  SearchClient.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import Foundation

class SearchClient {
    
    private let client: APIClientDataProtocol!
    
    typealias SearchCompletionResult = Result<[Question], Failure>
    typealias SearchCompletion = (_ result: SearchCompletionResult) -> Void
    
    var baseURL = APIEndpoint.Search.base
    
    init(withClient client: APIClientDataProtocol? = nil) {
        if let client = client {
            self.client = client
        } else {
            self.client = APIClient.client(withURL: baseURL) as? APIClientDataProtocol
        }
    }
    
    func search(for text: String, completion: @escaping SearchCompletion) {
        
        guard let client = self.client else {
            return completion(.failure(Failure(error: FailureReason.invalidClient)))
        }
        
        let path = APIEndpoint.Search.path
        let params: StringDictionary = [
            URLParams.Key.title: text,
            URLParams.Key.pageSize: "20",
            URLParams.Key.order: "desc",
            URLParams.Key.sort: "activity",
            URLParams.Key.site: "stackoverflow",
            URLParams.Key.filter: "withbody",
        ]
        
        client.getData(from: path, urlParams: params, options: nil) { (data, error, response) in
            if response == nil || error != nil {
                
                let reason: FailureReason?
                var responseReason: FailureReason? = nil
                
                if let response = response {
                    let statusCode = (error?.code == response.statusCode || error?.code == nil) ? response.statusCode : error?.code
                    reason = FailureReason(rawValue: statusCode ?? 0)
                    responseReason = FailureReason(rawValue: response.statusCode)
                } else {
                    reason = FailureReason(error: error)
                }
                
                return completion(.failure(Failure(error: reason ?? responseReason, message: ((reason == .unknown || reason == nil) ? error?.localizedDescription : "") as AnyObject)))
            } else if let response = response {
                guard response.statusCode == 200 else {
                    let reason = FailureReason(rawValue: response.statusCode)
                    return completion(.failure(Failure(error: reason)))
                }
                
                do {
                    let decoder = JSONDecoder()
                    
                    if let data = data as? Data {
                        let searchResult = try decoder.decode(SearchResult.self, from: data)
                        return completion(.success(payload: searchResult.questions))
                    } else {
                        debugLog(String(describing: Self.self), message: "The payload is not of expected type Data.")
                    }
                } catch let error {
                    debugLog(String(describing: Self.self), message: "Error decoding results: \(error)")
                }
                
                return completion(.failure(Failure(error: FailureReason.invalidResponse)))
            }
        }
    }
}

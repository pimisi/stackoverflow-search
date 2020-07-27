//
//  AnswersClient.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import Foundation

class AnswersClient {
    
    private let client: APIClientDataProtocol!
    
    typealias AnswersCompletionResult = Result<[Answer], Failure>
    typealias AnswersCompletion = (_ result: AnswersCompletionResult) -> Void
    
    var baseURL = APIEndpoint.Answers.base
    var lastSort: Answers.Sort?
    
    init(withClient client: APIClientDataProtocol? = nil) {
        if let client = client {
            self.client = client
        } else {
            self.client = APIClient.client(withURL: baseURL) as? APIClientDataProtocol
        }
    }
    
    func getAnswers(for questionID: Int, sortBy sort: Answers.Sort?,  completion: @escaping AnswersCompletion) {
        
        guard let client = self.client else {
            completion(.failure(Failure(error: FailureReason.invalidClient)))
            return
        }
        
        let path = APIEndpoint.Answers.path.replacingOccurrences(of: ":questionID", with: "\(questionID)")
        
        var params: StringDictionary = [
            URLParams.Key.order: Answers.Order.desc.rawValue,
            URLParams.Key.site: "stackoverflow",
            URLParams.Key.filter: "withbody",
            ]
        if (sort != Optional.none && sort != nil) {
            params = params + [URLParams.Key.sort: sort!.rawValue]
        }
                
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
                        let answers = try decoder.decode(Answers.self, from: data)
                        return completion(.success(payload: answers.items))
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

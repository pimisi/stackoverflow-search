//
//  FailureReason.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import Foundation

enum FailureReason: Int, Error {
    case unknown = 1
    case invalidClient = 2
    case notFound = 404
    case badRequest = 400
    case invalidResponse = 4002
    case invalidURL = 4006
    case preconditionFailed = 412
    case expectationFailed = 417
    case missingRequiredHeader = 4170
    case notImplemented = 501
    case internetConnectionOffline = -1009
    case sslError = -1200
    
    init(error: Error?) {
        self = FailureReason(rawValue: error?.code ?? 1) ?? .unknown
    }
    
    var message: String? {
        var _message: String?
        switch self {
        case .unknown: _message = "An unknown error occured."
        case .invalidClient: _message = "The client is invalid or nil"
        case .notFound: _message = "The resource was not found"
        case .badRequest: _message = "Bad request"
        case .invalidResponse: _message = "The response is invalid"
        case .invalidURL: _message = "The URL is invalid"
        case .preconditionFailed: _message = "Precondition was not met"
        case .expectationFailed: _message = "Expectation failed"
        case .missingRequiredHeader: _message = "The request is missing the required headers"
        case .notImplemented: _message = "The request has not been implemented"
        case .internetConnectionOffline: _message = "The internet connection is offline"
        case .sslError: _message = "An SSL error has occurred and a secure connection to the server cannot be made."
        }
        return _message
    }
}

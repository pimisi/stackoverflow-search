//
//  API.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import Foundation

typealias APIEndpoint = Constant.API.Endpoint

public extension Constant {
    class API: ConstantType {
        private static let bundle = Bundle(for: Constant.self)
        
        private class ServiceKey: ConstantType {
            static let `protocol` = "BaseAPIURIProtocol"
            static let stackoverflow = "BaseAPIURI"
        }
        
        class BaseURI: ConstantType {
            static let stackoverflow: String = {
                guard let `protocol` = Constant.infoDictionary![ServiceKey.protocol] as? String,  let uri = Constant.infoDictionary![ServiceKey.stackoverflow] as? String else {
                    debugLog("The BaseURI is not set because the service key '\(ServiceKey.stackoverflow)' is not present in the info dictionary")
                    return ""
                }
                
                return "\(`protocol`)://\(uri)"
            }()
        }
        
        static let errorDomain = "com.osiris"
        
        class Headers: ConstantType {
            class ContentType: ConstantType {
                static let key = "Content-Type"
                class value {
                    static let json = "application/json"
                }
                static let json = [key: value.json]
            }
            
            class Accept: ConstantType {
                static let key = "Accept"
                class value {
                    static let json = "application/json"
                }
                static let json = [key: value.json]
            }
        }
        
        class Endpoint: ConstantType {
            class Service: ConstantType {
                static let search = "/2.2/search/"
                static let questions = "/2.2/questions/"
            }
            
            class Search {
                static let base = BaseURI.stackoverflow + Service.search
                static let path = "advanced"
                static let uri = base + path
            }
            
            class Answers {
                static let base = BaseURI.stackoverflow + Service.questions
                static let path = ":questionID/answers"
                static let uri = base + path
            }
        }
        
    }
}

extension Constant.API  {
    class UIMessage: Constant.UIMessage {}
    class Message: Constant.Message {}
}

extension Constant.API  {
    class Network: ConstantType {
        class Error: ConstantType {
            static let noInternetConnection = UIMessage(title: "Internet connection unavailable", detail: "You are not connected to the internet.\n\nPlease connect and try again.")
            static let offline = UIMessage(title: "Network offline", detail: "The network is currently offline.\n\nPlease check your connection and try again.")
        }
        
        public class Status {
            public static let online = "NetowrkOnline"
            public static let unknown = "NetowrkUnknown"
            static let offline = "NetowrkOffline"
        }
    }
}

extension Constant.API {
    class Response: ConstantType {
        class Error: ConstantType {
            static let unknown = Message(debug: "An error occurred. Please try again later.")
            static let ssl = Message(ui: UIMessage(title: "Connection error", detail: "A connection could not be made."), debug: "SSL Error")
            static let internalServer = Message(ui: UIMessage(title: "Server error", detail: "An error occured on the server. It might be under maintenance at the moment. Please try again later."), debug: "Internal Server Error")
        }
    }
}


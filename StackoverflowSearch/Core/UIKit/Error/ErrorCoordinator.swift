//
//  ErrorCoordinator.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import UIKit

class ErrorCoordinator {
    static var shared = ErrorCoordinator()
    
    var error: Error? {
        didSet {
            processError()
        }
    }
    
    var action: ((UIAlertAction) -> Void)?
    
    func processError() {
        if let failure = error as? Failure, let error = failure.error {
            
            let uiMessage: Constant.UIMessage?
            
            switch error {
            case .internetConnectionOffline:
                uiMessage = Constant.API.Network.Error.noInternetConnection
            case .unknown: uiMessage = Constant.UIMessage(title: failure.title ?? "Error", detail: error.message!)
            case .sslError:
                uiMessage = Constant.API.Response.Error.ssl.ui
                debugLog(Constant.API.Response.Error.ssl.debug ?? "ssl error")
            default:
                uiMessage = error.message != nil ? Constant.UIMessage(title: failure.title ?? "Error", detail: failure.description) : nil
            }
            
            if uiMessage != nil {
                DispatchQueue.main.async {
                    if let uiMessage = uiMessage, let viewController = AppDelegate.rootViewController {
                        UIAlertController.okayAlert(withTitle: uiMessage.title, message: uiMessage.detail).withSecondary(handler: self.action).showIn(viewController, completion: {
                            self.action = nil
                        })
                    }
                }
            }
        }
    }
}

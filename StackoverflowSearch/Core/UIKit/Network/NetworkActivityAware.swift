//
//  NetworkActivityAware.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import Foundation

protocol NetworkActivityAware: class {}

extension NetworkActivityAware {
    var className: String {
        return String(describing: Self.self)
    }
    
    func networkActivityStarted() {
        networkActivityStatus = .started
    }
    
    func networkActivityComplete() {
        networkActivityStatus = .complete
    }
    
    var networkActivityStatus: NetworkActivity.Status? {
        get { return NetworkActivity.shared.status(for: className) }
        set {
            NetworkActivity.shared.setStatus(newValue, for: className)
        }
    }
}

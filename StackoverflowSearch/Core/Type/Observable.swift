//
//  Observable.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import Foundation

class Observable<T> {
    typealias Listener = ((T) -> Void)
    
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func observeOnce(_ listener: Listener?) {
        self.listener = listener
    }
    
    func observe(_ listener: Listener?) {
        self.listener = listener
        
        listener?(value)
    }
}

//
//  NetworkActivity.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import Foundation

class NetworkActivity {
    
    enum Status {
        case started, complete
    }
        
    static let shared = NetworkActivity()
    
    private(set) var status: Status?
    
    private var _completed: (() -> Void)?
    private var stopped: (() -> Void)?
    
    private var process: [AnyHashable: Status] = [:]
    
    var activityView: ActivityIndicatorView?
    
    var started: (() -> Void)? {
        didSet {
            status = .started
        }
    }
    
    /// Calling this directly removes the network activity for all other processes
    
    var completed: (() -> Void)? {
        get {
            stopped?()
            process.removeAll()
            return _completed
        }
        set {
            status = .complete
            _completed = newValue
        }
    }
    
    private init() {
        started = { [weak self] in
            DispatchQueue.main.async {
                if self?.activityView == nil {
                    let rootViewController = AppDelegate.rootViewController
                    let presentedView = rootViewController?.presentedViewController
                    
                    if let view = presentedView?.isBeingPresented == true ? rootViewController?.view : presentedView?.view ?? rootViewController?.view {
                        self?.activityView = ActivityIndicatorView.show(in: view)
                    }
                }
            }
        }
        
        stopped = { [weak self] in
            DispatchQueue.main.async {
                self?.activityView?.stop(stopped: {
                    self?.activityView = nil
                })
            }
        }
    }
    
    func status(for key: String) -> Status? {
        return process[key]
    }
    
    func setStatus(_ status: Status?, for key: String) {
        switch status {
            case .started:
                process.set(value: status, for: key)
                
                if self.status != .started {
                    started?()
                }
            case .complete:
                process.removeValue(forKey: key)
                
                if process.isEmpty {
                    completed?()
                }
            case .none: break
        }
    }
    
    
    
    
}

//
//  UIAlertController+Extension.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    public typealias AlertAction = ((UIAlertAction) -> Void)
    
    @objc public static func alert(withTitle title: String, message: String?) -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: .alert)
    }
    
    @objc public static func okayAlert(withTitle title: String, message: String?, handler: AlertAction? = nil) -> UIAlertController {
        let controller = alert(withTitle: title, message: message)
        controller.addAction(withTitle: "OK", style: .default, handler: handler)
        return controller
    }
    
    @objc public func withSecondary(title: String = "RETRY", handler: AlertAction?) -> UIAlertController {
        if handler != nil {
            let action = UIAlertAction(title: title, style: .default, handler: handler)
            self.addAction(action)
        }
        return self
    }
    
    @objc public func addAction(withTitle title: String, style: UIAlertAction.Style, handler: AlertAction?) {
        let action = UIAlertAction(title: title, style: style, handler: handler)
        self.addAction(action)
    }
    
    @objc public func showIn(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        viewController.present(self, animated: animated, completion: completion)
    }
    
}

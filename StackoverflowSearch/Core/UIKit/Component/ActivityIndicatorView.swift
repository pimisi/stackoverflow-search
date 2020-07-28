//
//  ActivityIndicatorView.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import UIKit
import Lottie

class ActivityIndicatorView: UIView {
    
    private static let lottieFile = "StackoverflowSearchLoader"
    let animationView: AnimationView = AnimationView(name: lottieFile)
    
    @discardableResult
    class func show(in view: UIView) -> ActivityIndicatorView {
        let indicatorView = ActivityIndicatorView(frame: view.bounds)
        indicatorView.isOpaque = false;
                
        view.addSubview(indicatorView)
        view.isUserInteractionEnabled = false
        
        let animationView: AnimationView = indicatorView.animationView
        animationView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        animationView.contentMode = .scaleAspectFill
        animationView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        animationView.center = view.center
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.0
        
        indicatorView.addSubview(animationView)
        
        view.addSubview(indicatorView)
        view.isUserInteractionEnabled = false
        
        indicatorView.backgroundColor = .white
        indicatorView.alpha = 0.9
        
        DispatchQueue.main.async {
            animationView.play()
        }
        
        return indicatorView
    }
    
    func show(in view: UIView) {
        view.addSubview(self)
        view.isUserInteractionEnabled = false
    }
    
    @objc public func stop(stopped: (() -> Void)? = nil) {
        self.superview?.isUserInteractionEnabled = true

        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0.0
        }) { _ in
            DispatchQueue.main.async {
                self.animationView.stop()
                self.removeFromSuperview()
            }
            stopped?()
        }
    }
}

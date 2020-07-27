//
//  UIView+Extension.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import UIKit

extension UIView {
    
    private func translatesAutoresizingMaskIntoConstraints(_ translate: Bool) {
        if translatesAutoresizingMaskIntoConstraints == !translate {
            translatesAutoresizingMaskIntoConstraints = translate
        }
    }
    
    func bordered(width: CGFloat = 0.0, radius: CGFloat = 0.0, color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.layer.cornerRadius = radius
    }
    
    func rounded(radius: CGFloat = 6) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func addSubviewConstrainedToEdges(_ subview: UIView, horizontal: CGFloat = 0, vertical: CGFloat = 0) {
        addSubviewConstrainedToEdges(subview, leading: horizontal, top: vertical, trailing: horizontal, bottom: vertical)
    }
    
    func addSubviewConstrainedToEdges(_ subview: UIView, leading: CGFloat = 0, top: CGFloat = 0, trailing: CGFloat = 0, bottom: CGFloat = 0) {
        addSubview(subview)
        
        subview.translatesAutoresizingMaskIntoConstraints(false)
        
        subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leading).isActive = true
        subview.topAnchor.constraint(equalTo: topAnchor, constant: top).isActive = true
        subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailing > 0 ? -trailing : trailing).isActive = true
        subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottom > 0 ? -bottom : bottom).isActive = true
    }
}

extension UIView {
    var asImage: UIImage? {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { context in
                layer.render(in: context.cgContext)
            }
        } else {
            UIGraphicsBeginImageContext(self.frame.size)
            self.layer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return UIImage(cgImage: image!.cgImage!)
        }
    }
}

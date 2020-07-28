//
//  UISegmentedControl+Extension.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import UIKit

extension UISegmentedControl {
    func ensureiOS12Style(borderColor: UIColor? = .black, selectedColor: UIColor? = .lightGray, selectedTextColor: UIColor? = .black) {
        if #available(iOS 13, *) {
            let imageSize = CGSize(width: 1, height: 32)
            let tintColorImage = UIImage(color: .clear, size: imageSize)
            let divider = UIImage(color: borderColor ?? tintColor, size: imageSize)
            let selectedColorImage = UIImage(color: selectedColor ?? borderColor ?? tintColor, size: imageSize)
            
            setBackgroundImage(tintColorImage, for: .normal, barMetrics: .default)
            setBackgroundImage(selectedColorImage, for: .selected, barMetrics: .default)
            
            // Divider color
            self.setDividerImage(divider, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
            
            // Border
            layer.borderWidth = 1
            layer.borderColor = (borderColor ?? tintColor).cgColor
            
            // Label color
            setTitleTextAttributes([.foregroundColor: tintColor ?? .black], for: .normal)
            setTitleTextAttributes([.foregroundColor: selectedTextColor ?? UIColor.white], for: .selected)
        } else {
            self.tintColor = tintColor
        }
    }
}

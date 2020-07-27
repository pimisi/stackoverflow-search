//
//  TagView.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import UIKit

class TagView: UIView {
    
    private let horizontalInset: CGFloat = 8.0
    private let verticalInset: CGFloat = 4.0
        
    lazy var tagLabel: UILabel! = {
        let label = UILabel()
        
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14.0)
        
        return label
    }()
    
    lazy var roundedRectView: UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30.0, height: 30.0)))
        
        view.rounded(radius: 4.0)
        view.backgroundColor = UIColor.mainOrange
        
        return view
    }()
    
    init(value: String, textColor: UIColor? = nil, backgroundColor: UIColor? = nil) {
        super.init(frame: .zero)
        configure(value: value, textColor: textColor, backgroundColor: backgroundColor)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configure(value: String, textColor: UIColor?, backgroundColor: UIColor?) {
        
        if let textColor = textColor {
            tagLabel.textColor = textColor
        }
        
        if let backgroundColor = backgroundColor {
            roundedRectView.backgroundColor = backgroundColor
        }
        
        self.backgroundColor = .clear
        
        tagLabel.text = value
        
        roundedRectView.addSubviewConstrainedToEdges(tagLabel, horizontal: horizontalInset, vertical: verticalInset)
        addSubviewConstrainedToEdges(roundedRectView)
        
        tagLabel.sizeToFit()
        setBounds()
    }
    
    private func setBounds() {
        let tagLabelFrame = tagLabel.bounds
        
        var adjustedLabelFrame = tagLabelFrame
        
        adjustedLabelFrame.origin.x = horizontalInset
        adjustedLabelFrame.origin.y = verticalInset
        
        tagLabel.frame = adjustedLabelFrame

        let height = tagLabelFrame.size.height + (verticalInset * 2)
        let width = tagLabelFrame.size.width + (horizontalInset * 2)
        
        let rect = CGRect(origin: .zero, size: CGSize(width: width, height: height))
        bounds = rect
        roundedRectView.frame = rect
    }
}

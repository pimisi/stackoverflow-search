//
//  UIImageView+Extension.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func loadImage(fromURLString urlString: String, reload: Bool = false) {
        if let url = URL(string: urlString) {
            loadImage(fromURL: url, reload: reload)
        }
    }
    
    func loadImage(fromURL url: URL, reload: Bool = false) {
        if image == nil || reload {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
        }
    }
}

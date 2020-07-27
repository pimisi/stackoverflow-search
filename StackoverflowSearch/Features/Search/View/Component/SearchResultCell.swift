//
//  SearchResultCell.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var footerLabel: UILabel!
    @IBOutlet weak var isAnswerImageView: UIImageView!
    @IBOutlet weak var accessoryIndicatorImage: UIImageView!
    @IBOutlet weak var answersLabel: UILabel!
    @IBOutlet weak var votesLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure()
    }
    
    private func configure() {
        titleLabel.textColor = UIColor.paleBlue
    }
    
}

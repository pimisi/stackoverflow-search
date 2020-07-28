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
    
    func populate(with question: Question) {
        titleLabel.text = "Q: \(question.title.stripHTMLTags)"
        
        bodyLabel.text = question.body.stripHTMLTags
        isAnswerImageView.alpha = question.isAnswered ? 1 : 0
        
        answersLabel.text = "\(question.answerCount.shortenedStringFormatted) answer\(question.answerCount > 1 ? "s" : "")"
        votesLabel.text = "\(question.votes.shortenedStringFormatted) vote\(question.votes > 1 ? "s" : "")"
        viewsLabel.text = "\(question.viewCount.shortenedStringFormatted) view\(question.viewCount > 1 ? "s" : "")"
        
        footerLabel.attributedText = NSAttributedString.attributtedString(for: question.owner.displayName, prefix: "asked \(question.dateCreated.asString(withFormat: DateFormatter.shortDateFormat)) by ", valueColor: UIColor.paleBlue, prefixColor: UIColor.black, fontSize: 10.0)
    }
    
}

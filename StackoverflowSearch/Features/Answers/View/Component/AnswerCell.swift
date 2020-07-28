//
//  AnswerCell.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import UIKit

class AnswerCell: UITableViewCell {
    
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var answeredByLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var reputationLabel: UILabel!
    
    @IBOutlet weak var votesLabel: UILabel!
    @IBOutlet weak var isAcceptedAnswerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure()
    }
    
    private func configure() {
        profileImageView.rounded(radius: 4)
        profileImageView.clipsToBounds = true
    }
    
    func populate(with answer: Answer) {
        bodyLabel.attributedText = answer.body.attributtedStringFromHTML
        votesLabel.attributedText = NSAttributedString.attributtedString(for: "\(answer.score)\nVote\(answer.score > 0 ? "s" : "")", fontSize: 10.0)
        
        isAcceptedAnswerImageView.alpha = answer.isAccepted ? 1 : 0
        
        answeredBy(answer)

        if let profileUrlString = answer.owner.profileImageURL {
            profileImageView.loadImage(fromURLString: profileUrlString)
        } else {
            profileImageView.image = nil
        }
        
        displayNameLabel.text = answer.owner.displayName.stripHTMLTags
        reputationLabel.text = "\(answer.owner.reputation.formatted)"
    }
    
    fileprivate func answeredBy(_ question: Answer) {
        let dateCreated: Date = question.dateCreated
        answeredByLabel.attributedText = NSAttributedString.attributtedString(for: "\(dateCreated.asString(withFormat: DateFormatter.mediumDateFormat)) at \(dateCreated.asString(withFormat: DateFormatter.twentyFourHourTimeFormat))", prefix: "Answered ", fontSize: 10.0)
    }
}

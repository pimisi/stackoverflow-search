//
//  QuestionDetailCell.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import UIKit

class QuestionDetailCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var askedLabel: UILabel!
    @IBOutlet weak var activeLabel: UILabel!
    @IBOutlet weak var viewedLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var tagsStackView: UIStackView!
    @IBOutlet weak var askedByLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var reputationLabel: UILabel!
    @IBOutlet weak var answersCountLabel: UILabel!
    @IBOutlet weak var filterSegmentControl: UISegmentedControl!
    
    @IBOutlet weak var tagsLabel: UILabel!
    
    var sortAnswersBy: ((_ by: Int) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure()
    }
    
    private func configure() {
        filterSegmentControl.ensureiOS12Style()
        profileImageView.rounded(radius: 4)
        profileImageView.clipsToBounds = true
    }
    
    func populateInBackground(with question: Question, sortingOn sorting: Int? = nil) {
        titleLabel.text = question.title.stripHTMLTags
        askedLabel.attributedText = nil
        answersCountLabel.text = "\(question.answerCount.shortenedStringFormatted) Answer\(question.answerCount > 1 ? "s" : "")"
        
        askedLabel.attributedText = NSAttributedString.attributtedString(for: "\(question.dateCreated.timeBeforeNow(suffix: "ago"))", prefix: "Asked ", fontSize: 10.0)
        if let lastActivityDate = question.lastActivityDate {
            activeLabel.attributedText = NSAttributedString.attributtedString(for: "\(lastActivityDate.timeBeforeNow(suffix: "ago"))", prefix: "Active ", fontSize: 10.0)
        } else {
            activeLabel.attributedText = nil
        }
        viewedLabel.attributedText = NSAttributedString.attributtedString(for: "\(question.viewCount.shortenedStringFormatted) times", prefix: "Viewed ", fontSize: 10.0)
        
        bodyLabel.attributedText = question.body.attributtedStringFromHTML
        
        askedBy(question)
        
        if let profileUrlString = question.owner.profileImageURL {
            profileImageView.loadImage(fromURLString: profileUrlString)
        } else {
            profileImageView.image = nil
        }
        
        displayNameLabel.text = question.owner.displayName.stripHTMLTags
        reputationLabel.text = "\(question.owner.reputation.formatted)"
        
        filterSegmentControl.selectedSegmentIndex = sorting ?? 2
        
        configureTags(from: question)
    }
    
    func populate(with question: Question, sortingOn sorting: Int? = nil) {
        DispatchQueue.main.async {
            self.populateInBackground(with: question, sortingOn: sorting)
        }
        
    }
    
    fileprivate func askedBy(_ question: Question) {
        let dateCreated: Date = question.dateCreated
        askedByLabel.attributedText = NSAttributedString.attributtedString(for: "\(dateCreated.asString(withFormat: DateFormatter.mediumDateFormat)) at \(dateCreated.asString(withFormat: DateFormatter.twentyFourHourTimeFormat))", prefix: "Asked ", fontSize: 10.0)
    }
    
    private func configureTags(from question: Question) {
        if let tags = question.tags, tags.count > 0 {
            let attributtedString = NSMutableAttributedString()
            
            tags.forEach { tag in
                if let image = TagView(value: tag).asImage {
                    attributtedString.appendImage(image)
                    attributtedString.addWordSpacing(2)
                }
            }
            
            tagsLabel.attributedText = attributtedString
        } else {
            tagsLabel.attributedText = nil
        }
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        sortAnswersBy?(sender.selectedSegmentIndex)
    }
}


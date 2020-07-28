//
//  AnswersViewController.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import UIKit

class AnswersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private static let questionCellIdentifier = "QuestionDetailCell"
    private static let cellIdentifier = "AnswerCell"
    
    let viewModel = AnswersViewModel()
    var question: Question?
    var answers: [Answer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "More Info"
        configureView()
        reloadTableView()
        getAnswers()
    }
    
    func configureView() {
        configureTableView()
        bindAnswers()
    }
    
    private func configureTableView() {
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorColor = UIColor.darkGray
        tableView.separatorInset = .zero
    }
    
    private func reloadTableView() {
        self.tableView.reloadData()
    }
    
    private func bindAnswers() {
        viewModel.list.observe { answers in
            DispatchQueue.main.async {
                self.answers = answers
                self.reloadTableView()
            }
        }
    }
    
    func getAnswers() {
        if let questionID = question?.id {
            viewModel.getAnswers(for: questionID)
        }
    }
}

extension AnswersViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: AnswersViewController.questionCellIdentifier, for: indexPath) as! QuestionDetailCell
            
            if let question = self.question {
                cell.populate(with: question, sortingOn: viewModel.sortAnswersBy?.index)
                cell.sortAnswersBy = { sortIndex in
                    self.viewModel.sortAnswersBy = Answers.Sort(index: sortIndex)
                }
            }
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AnswersViewController.cellIdentifier, for: indexPath) as! AnswerCell
        let answer = answers[indexPath.row]
        
        cell.populate(with: answer)
        
        return cell
    }
}

extension AnswersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

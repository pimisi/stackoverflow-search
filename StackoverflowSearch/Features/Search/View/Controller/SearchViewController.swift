//
//  SearchViewController.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private static let cellIdentifier = "SearchResultCell"
    private static let answersSequeIdentifier = "ShowAnswers"
    private static let noResultCellIdentifier = "NoResultCell"
    
    let viewModel = SearchViewModel()
    var questions: [Question] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
      if let indexPath = tableView.indexPathForSelectedRow {
        tableView.deselectRow(at: indexPath, animated: true)
      }
    }
    
    private func configure() {
        configureSearchBar()
        configureTableView()
        bindSearchResult()
    }
    
    private func configureSearchBar() {
        searchBar.backgroundColor = UIColor.mainOrange
        searchBar.barTintColor = UIColor.mainOrange
        
        searchBar.backgroundImage = UIImage()
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.bordered(width: 1.0, radius: 10.5, color: UIColor.darkGray)
        }
        
        searchBar.becomeFirstResponder()
    }
    
    private func configureTableView() {
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorColor = UIColor.darkGray
        tableView.separatorInset = UIEdgeInsets(top: 0.0, left: 4.0, bottom: 0.0, right: 4.0)
    }
    
    private func bindSearchResult() {
        viewModel.list.observe { questions in
            DispatchQueue.main.async {
                self.questions = questions
                self.reloadTableView()
            }
        }
    }
    
    private func reloadTableView() {
        tableView.separatorColor = viewModel.list.value.count > 0 ? UIColor.darkGray : UIColor.clear
        tableView.reloadData()
    }
    
    private func search(for text: String) {
        viewModel.search(for: text)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      guard
        segue.identifier == SearchViewController.answersSequeIdentifier,
        let indexPath = tableView.indexPathForSelectedRow,
        let answersViewController = segue.destination as? AnswersViewController
        else {
          return
      }
      
      let question = questions[indexPath.row]
      answersViewController.question = question
    }
}

extension SearchViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return  questions.count == 0 && !viewModel.listCleared ? 1 : 0// noResultCellIdentifier
        }
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchViewController.noResultCellIdentifier, for: indexPath)
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchViewController.cellIdentifier, for: indexPath) as! SearchResultCell
        let question = questions[indexPath.row]
        
        cell.populate(with: question)
        
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return tableView.frame.height
        }
        return UITableView.automaticDimension
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true);
        search(for: searchBar.text!)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.isEmpty == true {
            viewModel.clearQuestions()
        }
    }
}

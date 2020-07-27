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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        configureSearchBar()
        configureTableView()
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
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchViewController.cellIdentifier, for: indexPath) as! SearchResultCell
        
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

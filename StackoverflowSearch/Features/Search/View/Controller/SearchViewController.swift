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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        configureSearchBar()
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
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        return cell
    }
}

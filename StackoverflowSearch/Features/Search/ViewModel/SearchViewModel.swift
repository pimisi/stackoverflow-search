//
//  SearchViewModel.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import Foundation

class SearchViewModel: NetworkActivityAware {
    
    private let client = SearchClient()
    
    var list: Observable<[Question]> = Observable([])
    var networkError: Observable<Error?> = Observable(nil)
    var listCleared = true
        
    func search(for text: String) {
        networkActivityStarted()
        
        client.search(for: text) { result in
            self.listCleared = false
            switch result {
            case .success(let questions):
                self.list.value = questions
                self.networkActivityComplete()
            case .failure(let failure):
                debugLog(String(describing: Self.self), message: "Error fetching questions: \(String(describing: failure?.description))")
                self.networkActivityComplete()
                ErrorCoordinator.shared.error = failure
                self.networkError.value = failure
                
            }
        }
    }
    
    func clearQuestions() {
        list.value.removeAll()
        listCleared = true
    }
}

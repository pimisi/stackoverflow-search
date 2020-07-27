//
//  AnswersViewModel.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import Foundation

class AnswersViewModel: NetworkActivityAware {
    
    private let client = AnswersClient()
    
    var list: Observable<[Answer]> = Observable([])
    var networkError: Observable<Error?> = Observable(nil)
    var questionID: Int?
    
    var sortAnswersBy: Answers.Sort? = .votes {
        didSet {
            if let questionID = questionID {
                getAnswers(for: questionID)
            }
        }
    }
        
    func getAnswers(for questionID: Int) {
        networkActivityStarted()
        
        self.questionID = questionID
        
        client.getAnswers(for: questionID, sortBy: sortAnswersBy) { result in
            switch result {
            case .success(let questions):
                self.list.value = questions
                self.networkActivityComplete()
            case .failure(let failure):
                debugLog(String(describing: Self.self), message: "Error fetching answers: \(String(describing: failure?.description))")
                self.networkActivityComplete()
                ErrorCoordinator.shared.error = failure
                self.networkError.value = failure
                
            }
        }
    }
}

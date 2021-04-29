//
//  AcronymSearchViewModel.swift
//  Acronyms
//
//  Created by Douglas Poveda on 28/04/21.
//

import Foundation

class AcronymSearchViewModel: ObservableObject {
    private var repository: AcronymsRepository
    @Published var acronyms: [Acronym] = []
    
    init(repository: AcronymsRepository) {
        self.repository = repository
    }
    
    func getAcronyms(keyword: String) {
        let parameters = GetAcronymsParameters(keyword: keyword)
        repository.getAcronyms(parameters: parameters) { [unowned self] (result) in
            switch result {
            case .success(let response):
                self.acronyms = response
            case .failure:
                print("Not handled yet")
            }
        }
    }
}

//
//  AcronymSearchViewModel.swift
//  Acronyms
//
//  Created by Douglas Poveda on 28/04/21.
//

import Foundation

class AcronymSearchViewModel: ObservableObject {
    private var service: AcronymsService
    @Published var acronyms: [Acronym] = []
    
    init(service: AcronymsService) {
        self.service = service
    }
    
    func getAcronyms(keyword: String) {
        let parameters = GetAcronymsParameters(keyword: keyword)
        service.getAcronyms(parameters: parameters) { [unowned self] (result) in
            switch result {
            case .success(let response):
                self.acronyms = response
            case .failure:
                print("Not handled yet")
            }
        }
    }
}

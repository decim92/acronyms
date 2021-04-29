//
//  AcronymsRepository.swift
//  Acronyms
//
//  Created by Douglas Poveda on 28/04/21.
//

import Foundation

typealias GetAcronymsHandler = (Swift.Result<GetAcronymsResponse, NetworkServiceError>) -> Void

class SessionRepository {

    private var service: AcronymsService
    
    init(service: AcronymsService) {
        self.service = service
    }
    
    func getAcronyms(parameters: GetAcronymsParameters,
                  completion: @escaping GetAcronymsHandler) {
        service.getAcronyms(parameters: parameters, completion: completion)
    }
}

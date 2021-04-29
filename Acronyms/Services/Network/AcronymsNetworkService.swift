//
//  AcronymsNetworkService.swift
//  Acronyms
//
//  Created by Douglas Poveda on 28/04/21.
//


import Foundation

class AcronymsNetworkService: AcronymsService {

    func getAcronyms(parameters: GetAcronymsParameters,
                     completion: @escaping GetAcronymsHandler) {
        do {
            let request =
                try NetworkRouter.getAcronyms(parameters: parameters)
                .asURLRequest()
            
            let service = NetworkService(with: request)
            service.getAcronyms { result in
                completion(result)
            }
        } catch {
            completion(.failure(.unexpectedError))
        }
    }
}

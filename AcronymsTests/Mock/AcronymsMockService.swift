//
//  AcronymsMockService.swift
//  AcronymsTests
//
//  Created by Douglas Poveda on 28/04/21.
//

import Foundation
@testable import Acronyms

final class AcronymsMockService: AcronymsService {
    var acronyms = [Acronym(sf: "usa", lfs: [Meaning(lf: "Us Son At", freq: 145, since: 1946, vars: nil)])]
    func getAcronyms(parameters: GetAcronymsParameters, completion: @escaping GetAcronymsHandler) {
        let match = self.acronyms.contains { acronym in
            acronym.sf == parameters.keyword.lowercased()
        }
        if match {
            completion(.success(acronyms))
        } else {
            completion(.failure(.unexpectedError))
        }
    }
}

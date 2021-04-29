//
//  AcronymsService.swift
//  Acronyms
//
//  Created by Douglas Poveda on 28/04/21.
//

import Foundation

protocol AcronymsService {
    func getAcronyms(parameters: GetAcronymsParameters,
                  completion: @escaping GetAcronymsHandler)
}

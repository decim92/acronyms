//
//  AcronymsRequest.swift
//  Acronyms
//
//  Created by Douglas Poveda on 28/04/21.
//

import Foundation

struct GetAcronymsParameters: Parametrizable {
    let keyword:String
    
    func parameters() -> [String : Any] {
        return ["sf": keyword]
    }
}

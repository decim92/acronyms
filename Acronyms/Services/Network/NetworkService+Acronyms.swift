//
//  NetworkService+Acronyms.swift
//  Acronyms
//
//  Created by Douglas Poveda on 28/04/21.
//

import Foundation
import Alamofire

extension NetworkService {
    
    func getAcronyms(completion: @escaping (_ result: Swift.Result<GetAcronymsResponse, NetworkServiceError>) -> Void) {
        executeRequest(completion: completion)
    }
}

typealias GetAcronymsResponse = [Acronym]

struct Acronym: Codable, Identifiable {
    let id = UUID()
    var sf: String?
    var lfs: [Meaning]?
    
    enum CodingKeys: String, CodingKey {
        case sf
        case lfs
    }
}

struct Meaning: Codable, Identifiable {
    let id = UUID()
    var lf: String?
    var freq: Int?
    var since: Int?
    var vars: [Meaning]?
    
    enum CodingKeys: String, CodingKey {
        case lf
        case freq
        case since
        case vars
    }
}

//
//  NetworkRouter.swift
//  Acronyms
//
//  Created by Douglas Poveda on 28/04/21.
//

import Foundation
import Alamofire

enum NetworkRouter: URLRequestConvertible {
    enum NetworkRouterError: Error {
        case genericError
    }
    
    private struct Config {
        static let timeInterval = TimeInterval(10 * 1000)
    }

    private static let baseURLPath = "http://www.nactem.ac.uk/software/"
    
    case getAcronyms(parameters: GetAcronymsParameters)
    
    private var method: HTTPMethod {
        switch self {
        case .getAcronyms:
            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .getAcronyms:
            return "acromine/dictionary.py"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try NetworkRouter.baseURLPath.asURL()

        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.timeoutInterval = Config.timeInterval

        var requestEncoded: URLRequest
        switch self {
        case .getAcronyms(let parameters):
            requestEncoded = try URLEncoding.default.encode(request, with: parameters.parameters())
        }

        return requestEncoded
    }
}

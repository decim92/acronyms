//
//  NetworkService.swift
//  Acronyms
//
//  Created by Douglas Poveda on 28/04/21.
//

import Foundation
import Alamofire

class NetworkService {
    
    let router: URLRequestConvertible
    
    init(with router: URLRequestConvertible) {
        self.router = router
    }
    
    typealias NetworkCompletion = ((Swift.Result<Data?, NetworkError>) -> Void)
    var request: Alamofire.Request?

    private let sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
        return Session(configuration: configuration)
    }()

    func executeRequest<T: Decodable>(decodingNeeded: Bool = true, completion: @escaping (_ result: Swift.Result<T, NetworkServiceError>) -> Void) {
        AF.request(router).response { response in
            guard let result = response.response else {
                completion(.failure(.noResponse))
                return
            }
            switch result.statusCode {
            case 200...204:
                if !decodingNeeded {
                    completion(.success(true as! T))
                } else {
                    do {
                        guard let data = response.data else { throw NetworkServiceError.dataExpected }
                        let model = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(model))
                    } catch {
                        completion(.failure(.dataExpected))
                    }
                }
            default:
                completion(.failure(.unexpectedStatusCode(result.statusCode)))
            }
        }
    }
}

struct BackendGeneralError: Decodable {
    let errors: [String]
}

enum NetworkServiceError: Error {
    case error(AFError)
    case noResponse
    case statusCode
    case dataExpected
    case badRequest
    case unexpectedStatusCode(Int)
    case unexpectedError
}

enum NetworkError: String, Error {
    case generic = "There's an error that need to be validated"
}

//
//  AcronymsTests.swift
//  AcronymsTests
//
//  Created by Douglas Poveda on 28/04/21.
//

import XCTest
@testable import Acronyms

class AcronymsTests: XCTestCase {
    
    var repository: AcronymsRepository!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        repository = nil
    }

    func testNetworRouterGetAcronymsCase() throws {
        let parameters = GetAcronymsParameters(keyword: "test")
        let getAcronymsRequest = NetworkRouter.getAcronyms(parameters: parameters)
        XCTAssert(try getAcronymsRequest.asURLRequest().url?.absoluteString == "http://www.nactem.ac.uk/software/acromine/dictionary.py?sf=test")
    }
    
    func testAcronymsRepositoryGetAcronyms() throws {
        repository = AcronymsRepository(service: AcronymsMockService())
        repository.getAcronyms(parameters: GetAcronymsParameters(keyword: "usa")) { result in
            var acronyms = [Acronym]()
            switch result {
            case .success(let response):
                acronyms = response
            case .failure:
                print("")
            }
            XCTAssert(acronyms.count > 0)
        }
    }
    
    func testAcronymsRepositoryRealGetAcronyms() throws {
        let expectation = XCTestExpectation(description: "Get USA acronyms from a real web service")
        repository = AcronymsRepository(service: AcronymsNetworkService())
        repository.getAcronyms(parameters: GetAcronymsParameters(keyword: "usa")) { result in
            var acronyms = [Acronym]()
            switch result {
            case .success(let response):
                acronyms = response
            case .failure:
                print("")
            }
            XCTAssert(acronyms.first?.sf?.lowercased() ?? "" == "usa")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
}

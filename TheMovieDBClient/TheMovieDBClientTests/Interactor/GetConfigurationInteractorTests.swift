//
//  GetConfigurationInteractorTests.swift
//  TheMovieDBClientTests
//
//  Created by Rigoberto Saenz Imbacuan on 8/4/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

import XCTest
@testable import TheMovieDBClient

class GetConfigurationInteractorTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        Test.enableTestingMode()
        Test.setEndpointResult(fromFile: .getConfigurationEmpty)
    }

    func testRequest() {
        
        let expectation = XCTestExpectation(description: "ApiEndpoint.getConfiguration")
        let endpoint = ApiEndpoint.getConfiguration
        
        ApiRequest.request(to: endpoint) { response in
            
            switch response {
                
            case .success(let result):
                guard let jsonString = ApiUtils.getJsonString(from: result) else {
                    XCTFail()
                    return
                }
                XCTAssertEqual(jsonString, "")
                
            default:
                XCTFail()
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: Test.expectationTimeout)
    }
}

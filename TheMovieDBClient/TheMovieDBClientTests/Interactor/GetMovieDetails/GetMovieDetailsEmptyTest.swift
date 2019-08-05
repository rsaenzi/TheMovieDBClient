//
//  GetMovieDetailsEmptyTest.swift
//  TheMovieDBClientTests
//
//  Created by Rigoberto Saenz Imbacuan on 8/5/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

import XCTest
@testable import TheMovieDBClient

class GetMovieDetailsEmptyTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        Test.enableTestingMode()
        Test.setEndpointResult(fromFile: .getMovieDetailsEmpty)
    }
    
    func testRequest() {
        
        let expectation = XCTestExpectation(description: "ApiEndpoint.getMovieDetails")
        let endpoint = ApiEndpoint.getMovieDetails(movieId: 0)
        
        ApiRequest.request(to: endpoint) { response in
            
            switch response {
                
            case .success(let result):
                guard let jsonString = ApiUtils.getJsonString(from: result) else {
                    XCTFail("Error when converting Data object into Json string")
                    return
                }
                XCTAssertEqual(jsonString, "")
                
            default:
                XCTFail("Invalid response case")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: Test.expectationTimeout)
    }
}

//
//  GetPopularMoviesFullPage1Test.swift
//  TheMovieDBClientTests
//
//  Created by Rigoberto Saenz Imbacuan on 8/5/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

import XCTest
@testable import TheMovieDBClient

class GetPopularMoviesFullPage1Test: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        Test.enableTestingMode()
        Test.setEndpointResult(fromFile: .getPopularMoviesFullPage1)
    }
    
    func testRequest() {
        
        let expectation = XCTestExpectation(description: "ApiEndpoint.getPopularMovies")
        let endpoint = ApiEndpoint.getPopularMovies(page: 1)
        
        ApiRequest.request(to: endpoint) { response in
            
            switch response {
                
            case .success(let result):
                guard let jsonString = ApiUtils.getJsonString(from: result) else {
                    XCTFail("Error when converting Data object into Json string")
                    return
                }
                guard let content: PopularMovies = jsonString.decodeFrom() else {
                    XCTFail("Error when converting Json string into PopularMovies object")
                    return
                }
                
                XCTAssertNotNil(content)
                XCTAssertEqual(content.page, 1)
                XCTAssertEqual(content.totalResults, 19830)
                XCTAssertEqual(content.totalPages, 992)
                XCTAssertEqual(content.results.count, 20)
                
                XCTAssertEqual(content.results[0].id, 384018)
                XCTAssertEqual(content.results[0].title, "Fast & Furious Presents: Hobbs & Shaw")
                XCTAssertEqual(content.results[0].overview, "A spinoff of The Fate of the Furious, focusing on Johnson's US Diplomatic Security Agent Luke Hobbs forming an unlikely alliance with Statham's Deckard Shaw.")
                XCTAssertEqual(content.results[0].popularity, 452.935)
                XCTAssertEqual(content.results[0].releaseDate, "2019-08-01")
                XCTAssertEqual(content.results[0].genreIds, [28])
                XCTAssertEqual(content.results[0].originalTitle, "Fast & Furious Presents: Hobbs & Shaw")
                XCTAssertEqual(content.results[0].originalLanguage, "en")
                XCTAssertEqual(content.results[0].posterPath, "/keym7MPn1icW1wWfzMnW3HeuzWU.jpg")
                XCTAssertEqual(content.results[0].backdropPath, "/hpgda6P9GutvdkDX5MUJ92QG9aj.jpg")
                XCTAssertEqual(content.results[0].voteCount, 178)
                XCTAssertEqual(content.results[0].voteAverage, 6.8)
                XCTAssertEqual(content.results[0].video, false)
                XCTAssertEqual(content.results[0].adult, false)
                
            default:
                XCTFail("Invalid response case")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: Test.expectationTimeout)
    }
}

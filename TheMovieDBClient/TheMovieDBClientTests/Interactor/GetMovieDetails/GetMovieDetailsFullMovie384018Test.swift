//
//  GetMovieDetailsFullMovie384018Test.swift
//  TheMovieDBClientTests
//
//  Created by Rigoberto Saenz Imbacuan on 8/5/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

import XCTest
@testable import TheMovieDBClient

class GetMovieDetailsFullMovie384018Test: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        Test.enableTestingMode()
        Test.setEndpointResult(fromFile: .getMovieDetailsFullMovie384018)
    }
    
    func testRequest() {
        
        let expectation = XCTestExpectation(description: "ApiEndpoint.getMovieDetails")
        let endpoint = ApiEndpoint.getMovieDetails(movieId: 384018)
        
        ApiRequest.request(to: endpoint) { response in
            
            switch response {
                
            case .success(let result):
                guard let jsonString = ApiUtils.getJsonString(from: result) else {
                    XCTFail("Error when converting Data object into Json string")
                    return
                }
                guard let content: MovieDetails = jsonString.decodeFrom() else {
                    XCTFail("Error when converting Json string into MovieDetails object")
                    return
                }
                
                XCTAssertNotNil(content)
                XCTAssertEqual(content.id, 384018)
                XCTAssertEqual(content.title, "Fast & Furious Presents: Hobbs & Shaw")
                XCTAssertEqual(content.overview, "A spinoff of The Fate of the Furious, focusing on Johnson's US Diplomatic Security Agent Luke Hobbs forming an unlikely alliance with Statham's Deckard Shaw.")
                XCTAssertEqual(content.popularity, 452.935)
                XCTAssertEqual(content.releaseDate, "2019-08-01")
                XCTAssertEqual(content.originalTitle, "Fast & Furious Presents: Hobbs & Shaw")
                XCTAssertEqual(content.originalLanguage, "en")
                XCTAssertEqual(content.posterPath, "/keym7MPn1icW1wWfzMnW3HeuzWU.jpg")
                XCTAssertEqual(content.backdropPath, "/hpgda6P9GutvdkDX5MUJ92QG9aj.jpg")
                XCTAssertEqual(content.voteCount, 181)
                XCTAssertEqual(content.voteAverage, 6.8)
                XCTAssertEqual(content.video, false)
                XCTAssertEqual(content.adult, false)
                XCTAssertEqual(content.homepage, "https://www.hobbsandshawmovie.com")
                XCTAssertEqual(content.imdbId, "tt6806448")
                XCTAssertEqual(content.budget, 200000000)
                XCTAssertEqual(content.revenue, 0)
                XCTAssertEqual(content.runtime, 133)
                XCTAssertEqual(content.status, "Released")
                XCTAssertEqual(content.tagline, "")
                
                XCTAssertEqual(content.genres[0].id, 28)
                XCTAssertEqual(content.genres[0].name, "Action")
                
                XCTAssertEqual(content.productionCompanies[0].id, 33)
                XCTAssertEqual(content.productionCompanies[0].name, "Universal Pictures")
                XCTAssertEqual(content.productionCompanies[0].logoPath, "/8lvHyhjr8oUKOOy2dKXoALWKdp0.png")
                XCTAssertEqual(content.productionCompanies[0].originCountry, "US")
                
                XCTAssertEqual(content.productionCountries[0].name, "United States of America")
                XCTAssertEqual(content.productionCountries[0].iso31661, "US")
                
                XCTAssertEqual(content.spokenLanguages[0].name, "English")
                XCTAssertEqual(content.spokenLanguages[0].iso6391, "en")
                XCTAssertEqual(content.spokenLanguages[1].name, "Italiano")
                XCTAssertEqual(content.spokenLanguages[1].iso6391, "it")
                
            default:
                XCTFail("Invalid response case")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: Test.expectationTimeout)
    }
}

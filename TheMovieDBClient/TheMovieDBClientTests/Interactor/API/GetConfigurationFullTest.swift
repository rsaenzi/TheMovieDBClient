//
//  GetConfigurationFullTest.swift
//  TheMovieDBClientTests
//
//  Created by Rigoberto Saenz Imbacuan on 8/5/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

import XCTest
@testable import TheMovieDBClient

class GetConfigurationFullTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        Test.enableTestingMode()
        Test.setEndpointResult(fromFile: .getConfigurationFull)
    }
    
    func testRequest() {
        
        let expectation = XCTestExpectation(description: "ApiEndpoint.getConfiguration")
        let endpoint = ApiEndpoint.getConfiguration
        
        ApiRequest.request(to: endpoint) { response in
            
            switch response {
                
            case .success(let result):
                guard let jsonString = ApiUtils.getJsonString(from: result) else {
                    XCTFail("Error when converting Data object into Json string")
                    return
                }
                guard let content: Configuration = jsonString.decodeFrom() else {
                    XCTFail("Error when converting Json string into Configuration object")
                    return
                }
                
                XCTAssertNotNil(content)
                XCTAssertEqual(content.images.baseUrl, "http://image.tmdb.org/t/p/")
                XCTAssertEqual(content.images.secureBaseUrl, "https://image.tmdb.org/t/p/")
                
                XCTAssertEqual(content.images.backdropSizes[0], "w300")
                XCTAssertEqual(content.images.backdropSizes[1], "w780")
                XCTAssertEqual(content.images.backdropSizes[2], "w1280")
                XCTAssertEqual(content.images.backdropSizes[3], "original")
                
                XCTAssertEqual(content.images.logoSizes[0], "w45")
                XCTAssertEqual(content.images.logoSizes[1], "w92")
                XCTAssertEqual(content.images.logoSizes[2], "w154")
                XCTAssertEqual(content.images.logoSizes[3], "w185")
                XCTAssertEqual(content.images.logoSizes[4], "w300")
                XCTAssertEqual(content.images.logoSizes[5], "w500")
                XCTAssertEqual(content.images.logoSizes[6], "original")
                
                XCTAssertEqual(content.images.posterSizes[0], "w92")
                XCTAssertEqual(content.images.posterSizes[1], "w154")
                XCTAssertEqual(content.images.posterSizes[2], "w185")
                XCTAssertEqual(content.images.posterSizes[3], "w342")
                XCTAssertEqual(content.images.posterSizes[4], "w500")
                XCTAssertEqual(content.images.posterSizes[5], "w780")
                XCTAssertEqual(content.images.posterSizes[6], "original")
                
                XCTAssertEqual(content.images.profileSizes[0], "w45")
                XCTAssertEqual(content.images.profileSizes[1], "w185")
                XCTAssertEqual(content.images.profileSizes[2], "h632")
                XCTAssertEqual(content.images.profileSizes[3], "original")
                
                XCTAssertEqual(content.images.stillSizes[0], "w92")
                XCTAssertEqual(content.images.stillSizes[1], "w185")
                XCTAssertEqual(content.images.stillSizes[2], "w300")
                XCTAssertEqual(content.images.stillSizes[3], "original")
                
                XCTAssertEqual(content.changeKeys[0], "adult")
                XCTAssertEqual(content.changeKeys[1], "air_date")
                XCTAssertEqual(content.changeKeys[2], "also_known_as")
                XCTAssertEqual(content.changeKeys[3], "alternative_titles")
                XCTAssertEqual(content.changeKeys[4], "biography")
                XCTAssertEqual(content.changeKeys[5], "birthday")
                XCTAssertEqual(content.changeKeys[6], "budget")
                XCTAssertEqual(content.changeKeys[7], "cast")
                XCTAssertEqual(content.changeKeys[8], "certifications")
                XCTAssertEqual(content.changeKeys[9], "character_names")
                XCTAssertEqual(content.changeKeys[10], "created_by")
                XCTAssertEqual(content.changeKeys[11], "crew")
                XCTAssertEqual(content.changeKeys[12], "deathday")
                XCTAssertEqual(content.changeKeys[13], "episode")
                XCTAssertEqual(content.changeKeys[14], "episode_number")
                XCTAssertEqual(content.changeKeys[15], "episode_run_time")
                XCTAssertEqual(content.changeKeys[16], "freebase_id")
                XCTAssertEqual(content.changeKeys[17], "freebase_mid")
                XCTAssertEqual(content.changeKeys[18], "general")
                XCTAssertEqual(content.changeKeys[19], "genres")
                XCTAssertEqual(content.changeKeys[20], "guest_stars")
                XCTAssertEqual(content.changeKeys[21], "homepage")
                XCTAssertEqual(content.changeKeys[22], "images")
                XCTAssertEqual(content.changeKeys[23], "imdb_id")
                XCTAssertEqual(content.changeKeys[24], "languages")
                XCTAssertEqual(content.changeKeys[25], "name")
                XCTAssertEqual(content.changeKeys[26], "network")
                XCTAssertEqual(content.changeKeys[27], "origin_country")
                XCTAssertEqual(content.changeKeys[28], "original_name")
                XCTAssertEqual(content.changeKeys[29], "original_title")
                XCTAssertEqual(content.changeKeys[30], "overview")
                XCTAssertEqual(content.changeKeys[31], "parts")
                XCTAssertEqual(content.changeKeys[32], "place_of_birth")
                XCTAssertEqual(content.changeKeys[33], "plot_keywords")
                XCTAssertEqual(content.changeKeys[34], "production_code")
                XCTAssertEqual(content.changeKeys[35], "production_companies")
                XCTAssertEqual(content.changeKeys[36], "production_countries")
                XCTAssertEqual(content.changeKeys[37], "releases")
                XCTAssertEqual(content.changeKeys[38], "revenue")
                XCTAssertEqual(content.changeKeys[39], "runtime")
                XCTAssertEqual(content.changeKeys[40], "season")
                XCTAssertEqual(content.changeKeys[41], "season_number")
                XCTAssertEqual(content.changeKeys[42], "season_regular")
                XCTAssertEqual(content.changeKeys[43], "spoken_languages")
                XCTAssertEqual(content.changeKeys[44], "status")
                XCTAssertEqual(content.changeKeys[45], "tagline")
                XCTAssertEqual(content.changeKeys[46], "title")
                XCTAssertEqual(content.changeKeys[47], "translations")
                XCTAssertEqual(content.changeKeys[48], "tvdb_id")
                XCTAssertEqual(content.changeKeys[49], "tvrage_id")
                XCTAssertEqual(content.changeKeys[50], "type")
                XCTAssertEqual(content.changeKeys[51], "video")
                XCTAssertEqual(content.changeKeys[52], "videos")
                
            default:
                XCTFail("Invalid response case")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: Test.expectationTimeout)
    }
}

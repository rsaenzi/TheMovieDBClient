//
//  GetPopularMoviesContent.swift
//  TheMovieDBClient
//
//  Created by Rigoberto Saenz Imbacuan on 7/20/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

struct GetPopularMoviesContent: Codable {
    
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [MovieResult]
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results = "results"
    }
}

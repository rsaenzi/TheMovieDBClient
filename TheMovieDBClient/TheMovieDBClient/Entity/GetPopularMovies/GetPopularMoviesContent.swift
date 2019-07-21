//
//  GetPopularMoviesContent.swift
//  TheMovieDBClient
//
//  Created by Rigoberto Saenz Imbacuan on 7/20/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

struct GetPopularMoviesContent: Codable {
    let page: Int
    let total_results: Int
    let total_pages: Int
    let results: [MovieResult]
}

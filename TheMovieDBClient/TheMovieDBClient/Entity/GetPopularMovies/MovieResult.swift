//
//  MovieResult.swift
//  TheMovieDBClient
//
//  Created by Rigoberto Saenz Imbacuan on 7/20/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

struct MovieResult: Codable {
    let id: Int
    let title: String
    let overview: String
    let popularity: Float
    let release_date: String
    let genre_ids: [Int]
    let original_title: String
    let original_language: String
    let poster_path: String?
    let backdrop_path: String?
    let vote_count: Int
    let vote_average: Float
    let video: Bool
    let adult: Bool
}

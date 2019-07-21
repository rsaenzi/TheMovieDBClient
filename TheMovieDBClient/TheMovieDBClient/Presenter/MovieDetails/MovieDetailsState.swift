//
//  MovieDetailsState.swift
//  TheMovieDBClient
//
//  Created by Rigoberto Saenz Imbacuan on 7/20/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

enum MovieDetailsState {
    case noData
    case fetchingData
    case dataAvailable(movie: MovieDetails)
    case noInternet
    case error(key: LanguageKey)
}

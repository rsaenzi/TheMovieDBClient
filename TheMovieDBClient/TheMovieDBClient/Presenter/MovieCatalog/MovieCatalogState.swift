//
//  MovieCatalogState.swift
//  TheMovieDBClient
//
//  Created by Rigoberto Saenz Imbacuan on 7/20/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

enum MovieCatalogState {
    case noData
    case fetchingData
    case dataAvailable(movies: [MovieResult])
    case noInternet
    case error(key: LanguageKey)
}

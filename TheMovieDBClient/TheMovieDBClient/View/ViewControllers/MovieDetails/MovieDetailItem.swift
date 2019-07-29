//
//  MovieDetailItem.swift
//  TheMovieDBClient
//
//  Created by Rigoberto Saenz Imbacuan on 7/24/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

import UIKit

enum MovieDetailItem {
    case header(title: String, backdropImage: String?, posterImage: String?)
    case rating(rating: Float, releaseDate: String)
    case tagline(tagline: String)
    case overview(overview: String)
    case homepage(homepage: String)
    case imdb(imdbId: String)
    case genre(genre: Genre)
    case original(title: String)
    case production(company: ProductionCompany)
    case country(country: ProductionCountry)
    case revenue(revenue: Int)
    case budget(budget: Int)
}

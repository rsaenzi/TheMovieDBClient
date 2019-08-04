//
//  MovieDetailItem.swift
//  TheMovieDBClient
//
//  Created by Rigoberto Saenz Imbacuan on 7/24/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

enum MovieDetailItem {
    case header(title: String, backdropImage: String?, posterImage: String?)
    case rating(rating: String, count: String)
    case release(releaseDate: String)
    case tagline(tagline: String)
    case overview(overview: String)
    case homepage(homepage: String)
    case imdb(imdbUrl: String)
    case genreTitle(title: String)
    case genre(genre: String)
    case original(title: String, language: String)
    case companyTitle
    case company(company: String, logoPath: String?, originCountry: String)
    case countryTitle
    case country(country: String, isoCode: String)
    case revenue(revenue: String)
    case budget(budget: String)
}

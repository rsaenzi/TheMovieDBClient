//
//  ApiEndpoint.swift
//  TheMovieDBClient
//
//  Created by Rigoberto Saenz Imbacuan on 7/20/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

import Moya

enum ApiEndpoint {
    
    /*
     Get the system wide configuration information. Some elements of the API require some knowledge of this configuration data. The purpose of this is to try and keep the actual API responses as light as possible.
     https://developers.themoviedb.org/3/configuration/get-api-configuration
     */
    case getConfiguration
    
    /*
     Get a list of the current popular movies on TMDb. This list updates daily.
     https://developers.themoviedb.org/3/movies/get-popular-movies
     */
    case getPopularMovies(page: Int)
    
    /*
     Get the primary information about a movie.
     https://developers.themoviedb.org/3/movies/get-movie-details
     */
    case getMovieDetails(movieId: Int)
}

extension ApiEndpoint: TargetType {
    
    var baseURL: URL {
        return URL(string: ApiCredentials.apiURL)!
    }
    
    var path: String {
        switch self {
            
        case .getConfiguration:
            return "/configuration"
            
        case .getPopularMovies:
            return "/movie/popular"
            
        case .getMovieDetails(let movieId):
            return "/movie/\(movieId)"
        }
    }
    
    var method: Method {
        switch self {
            
        case .getConfiguration, .getPopularMovies, .getMovieDetails:
            return .get
        }
    }
    
    var headers: [String: String]? {
        var headers = [String: String]()
        headers["Accept"] = "application/json"
        headers["Content-type"] = "application/json"
        return headers
    }
    
    var task: Task {
        
        var parameters = [String: Any]()
        parameters["api_key"] = ApiCredentials.apiKey
        
        if let lang = Locale.current.languageCode,
            let region = Locale.current.regionCode {
            parameters["language"] = "\(lang)-\(region)"
        }
        
        switch self {
            
        case .getConfiguration, .getMovieDetails:
            return .requestParameters(
                parameters: parameters,
                encoding: URLEncoding.queryString)
            
        case .getPopularMovies(let page):
            parameters["page"] = page
            
            return .requestParameters(
                parameters: parameters,
                encoding: URLEncoding.queryString)
        }
    }
    
    var sampleData: Data {
        return "".utf8Encoded
    }
}

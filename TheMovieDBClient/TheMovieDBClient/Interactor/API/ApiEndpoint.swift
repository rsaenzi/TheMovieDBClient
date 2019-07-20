//
//  ApiEndpoint.swift
//  TheMovieDBClient
//
//  Created by Rigoberto Saenz Imbacuan on 7/20/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

import Moya

enum ApiEndpoint {
    
    // Get a list of the current popular movies on TMDb. This list updates daily.
    case getPopularMovies(page: Int?)
}

extension ApiEndpoint: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }
    
    var path: String {
        switch self {
            
        case .getPopularMovies:
            return "/movie/popular"
        }
    }
    
    var method: Method {
        switch self {
            
        case .getPopularMovies:
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
        switch self {
            
        case .getPopularMovies(let page):
            
            var parameters = [String: Any]()
            
            // TODO: Obfuscate this
            parameters["api_key"] = "ae79474bf16e5cab759a3f4f078a4f5e"
            
            if let lang = Locale.current.languageCode,
                let region = Locale.current.regionCode {
                parameters["language"] = "\(lang)-\(region)"
            }
            
            if let validPage = page {
                parameters["page"] = validPage
            }
            
            return .requestParameters(
                parameters: parameters,
                encoding: URLEncoding.queryString)
        }
    }
    
    var sampleData: Data {
        return "".utf8Encoded
    }
}

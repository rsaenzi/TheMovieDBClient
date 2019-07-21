//
//  GetPopularMoviesResponse.swift
//  TheMovieDBClient
//
//  Created by Rigoberto Saenz Imbacuan on 7/20/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

import Moya

enum GetPopularMoviesResponse {
    
    // API Errors
    case success(content: GetPopularMoviesContent)
    case unauthorizedError(jsonString: String)
    case resourceNotFoundError(jsonString: String)
    
    // Response Errors
    case responseDataError(response: Moya.Response)
    case redirectionError(jsonString: String)
    case clientError(jsonString: String)
    case serverError(jsonString: String)
    case invalidResponseError(jsonString: String)
    
    // Request Errors
    case jsonDecodingError(jsonString: String)
    case requestFailureError(error: String)
    case requestOfflineError(error: String)
    case requestTimeOutError(error: String)
}

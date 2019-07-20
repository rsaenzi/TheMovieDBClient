//
//  GetPopularMoviesInteractor.swift
//  TheMovieDBClient
//
//  Created by Rigoberto Saenz Imbacuan on 7/20/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

import Moya

typealias GetPopularMoviesCallback = (_ response: GetPopularMoviesResponse) -> Void

class GetPopularMoviesInteractor {
    
    private init() {}
    
    static func request(page: Int?, completion callback: @escaping GetPopularMoviesCallback) {
        
        let endpoint = ApiEndpoint.getPopularMovies(page: page)
        
        ApiRequest.request(to: endpoint) { response in
            switch response {
                
            case .success(let result):
                process(result, callback)
                
            case .failure(let error):
                call(callback, for: .requestFailureError(error: error))
                
            case .offline(let error):
                call(callback, for: .requestOfflineError(error: error))
                
            case .timeOut(let error):
                call(callback, for: .requestTimeOutError(error: error))
            }
        }
    }
    
    private static func process(_ result: Response, _ callback: @escaping GetPopularMoviesCallback) {
        
        let code = result.statusCode
        
        // Convert raw data into a json string
        guard let jsonString = ApiUtils.getJsonString(from: result) else {
            call(callback, for: .responseDataError(response: result))
            return
        }
        
        // HTTP status code validation
        switch code {
        case 200:
            process(jsonString, callback)
            
        case 401, 403:
            call(callback, for: .unauthorizedError(jsonString: jsonString))
            
        case 404:
            call(callback, for: .resourceNotFoundError(jsonString: jsonString))
            
        case 300...399:
            call(callback, for: .redirectionError(jsonString: jsonString))
            
        case 400...499:
            call(callback, for: .clientError(jsonString: jsonString))
            
        case 500...599:
            call(callback, for: .serverError(jsonString: jsonString))
            
        default:
            call(callback, for: .invalidResponseError(jsonString: jsonString))
        }
    }
    
    private static func process(_ jsonString: String, _ callback: @escaping GetPopularMoviesCallback) {
        
        // Converts the jsonString into a valid Object
        guard let content: GetPopularMoviesContent = jsonString.decodeFrom() else {
            call(callback, for: .jsonDecodingError(jsonString: jsonString))
            return
        }
        
        // Returns the parsed object
        call(callback, for: .success(content: content))
    }
    
    private static func call(_ callback: @escaping GetPopularMoviesCallback, for result: GetPopularMoviesResponse) {
        DispatchQueue.main.async {
            callback(result)
        }
    }
}


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


struct GetPopularMoviesContent: Codable {
    let status: String
    let page: Int
    let movies: [Movie]
}

struct Movie: Codable {
    let name: String
}

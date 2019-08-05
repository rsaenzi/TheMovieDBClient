//
//  ApiResponse.swift
//  TheMovieDBClient
//
//  Created by Rigoberto Saenz Imbacuan on 8/5/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

import Moya

enum ApiResponse {
    case success(result: Response)
    case failure(error: String)
    case offline(error: String)
    case timeOut(error: String)
}

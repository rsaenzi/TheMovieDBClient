//
//  MovieDetailsState.swift
//  TheMovieDBClient
//
//  Created by Rigoberto Saenz Imbacuan on 7/20/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

import UIKit

enum MovieDetailsState {
    case success(newIndexPaths: [IndexPath])
    case error
}

//
//  Image.swift
//  TheMovieDBClient
//
//  Created by Rigoberto Saenz Imbacuan on 7/20/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

import UIKit

enum Image: String {
    case AppIconWhite
    case AppTitleIcon
    case CalendarWhite
    case CountryWhite
    case CurrencyWhite
    case DownloadingWhite
    case ErrorWhite
    case GenreWhite
    case NoInternetWhite
    case OriginalWhite
    case ProducedByWhite
    case StarWhite
}

extension Image {
    
    func image() -> UIImage {
        return UIImage(named: self.rawValue) ?? UIImage()
    }
}

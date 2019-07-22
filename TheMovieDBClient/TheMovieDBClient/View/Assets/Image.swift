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
    case CalendarWhite
    case StarWhite
}

extension Image {
    
    func image() -> UIImage {
        return UIImage(named: self.rawValue) ?? UIImage()
    }
}

//
//  UIColor+Named.swift
//  TheMovieDBClient
//
//  Created by Rigoberto Saenz Imbacuan on 7/18/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

import UIKit

enum Color: String {
    case mainFucsia
    case mainBlue
}

extension Color {
    
    func color() -> UIColor {
        return UIColor(named: self.rawValue) ?? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
}

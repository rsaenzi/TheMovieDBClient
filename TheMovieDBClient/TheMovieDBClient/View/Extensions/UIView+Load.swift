//
//  UIView+Load.swift
//  TheMovieDBClient
//
//  Created by Rigoberto Saenz Imbacuan on 7/25/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

import UIKit

extension UIView {
    
    static func getNib() -> UINib {
        let nibName = className(some: self)
        return UINib(nibName: nibName, bundle: nil)
    }
}

private func className(some: Any) -> String {
    return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
}

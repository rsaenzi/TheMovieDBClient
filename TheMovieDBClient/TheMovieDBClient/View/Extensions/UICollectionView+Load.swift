//
//  UICollectionView+Load.swift
//  TheMovieDBClient
//
//  Created by Rigoberto Saenz Imbacuan on 7/18/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    /**
     This function works if the UICollectionViewCell class and the Cell Identifier are the same
     */
    func dequeue<T: UICollectionViewCell>(_ indexPath: IndexPath) -> T {
        
        let identifier = className(some: T.self)
        let rawCell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        guard let cell = rawCell as? T else {
            fatalError("UICollectionViewCell with identifier '\(identifier)' was not found")
        }
        return cell
    }
}

extension UICollectionViewCell {
    
    static func getReuseIdentifier() -> String {
        return className(some: self)
    }
}

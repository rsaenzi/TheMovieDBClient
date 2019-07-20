//
//  UITableView+Load.swift
//  TheMovieDBClient
//
//  Created by Rigoberto Saenz Imbacuan on 7/18/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

import UIKit

extension UITableView {
    
    /**
     This function works if the UITableViewCell class and the Cell Identifier are the same
     */
    func dequeue<T: UITableViewCell>(_ indexPath: IndexPath) -> T {
        
        let identifier = className(some: T.self)
        let rawCell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        guard let cell = rawCell as? T else {
            fatalError("UITableViewCell with identifier '\(identifier)' was not found")
        }
        return cell
    }
}

private func className(some: Any) -> String {
    return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
}

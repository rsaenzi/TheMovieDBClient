//
//  MovieDetailTaglineCell.swift
//  TheMovieDBClient
//
//  Created by Rigoberto Saenz Imbacuan on 7/24/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

import UIKit

class MovieDetailTaglineCell: UITableViewCell {
    
    // MARK: Outlets
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) { // From Code
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) { // From IB
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        
        // Expand to fill its parent
//        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}

// MARK: Data
extension MovieDetailTaglineCell {
    
    func setup(tagline: String?) {
        self.selectionStyle = .none
    }
}

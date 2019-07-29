//
//  MovieDetailHeaderCell.swift
//  TheMovieDBClient
//
//  Created by Rigoberto Saenz Imbacuan on 7/24/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

import UIKit

class MovieDetailHeaderCell: UITableViewCell {
    
    // MARK: Outlets
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    
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
extension MovieDetailHeaderCell {
    
    func setup(title: String, backdropImage: String?, posterImage: String?) {
        self.selectionStyle = .none
    }
}

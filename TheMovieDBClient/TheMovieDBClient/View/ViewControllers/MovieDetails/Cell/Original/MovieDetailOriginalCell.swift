//
//  MovieDetailOriginalCell.swift
//  TheMovieDBClient
//
//  Created by Rigoberto Saenz Imbacuan on 7/24/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

import UIKit

class MovieDetailOriginalCell: UITableViewCell {
    
    // This property must be bound to the whole view in Interface Builder
    @IBOutlet private weak var allContentView: UIView!
    
    // MARK: Outlets
    @IBOutlet private weak var originalTitleLabel: UILabel!
    
    // From Code
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    // From IB
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
}

// MARK: Init
extension MovieDetailOriginalCell {
    
    private func commonInit() {
        
        // Name of the .xib file
        let nibName = className(some: self)
        
        // Load and add this custom view
        Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
        addSubview(allContentView)
        
        // Expand to fill its parent
        allContentView.frame = self.bounds
        allContentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        // This prevent the cell to change its color when selected
        selectionStyle = .none
    }
}

// MARK: Setup
extension MovieDetailOriginalCell {
    
    func setup(title: String, language: String) {
        
        if language.count > 0 {
            originalTitleLabel.text = "\(title) (\(language.uppercased()))"
        } else {
            originalTitleLabel.text = title
        }
    }
}

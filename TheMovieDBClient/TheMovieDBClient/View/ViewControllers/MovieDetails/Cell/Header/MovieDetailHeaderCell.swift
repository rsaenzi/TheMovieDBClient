//
//  MovieDetailHeaderCell.swift
//  TheMovieDBClient
//
//  Created by Rigoberto Saenz Imbacuan on 7/24/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailHeaderCell: UITableViewCell {
    
    // This property must be bound to the whole view in Interface Builder
    @IBOutlet private weak var allContentView: UIView!
    
    // MARK: Outlets
    @IBOutlet private weak var backdropImage: UIImageView!
    @IBOutlet private weak var posterImage: UIImageView!
    @IBOutlet private weak var movieTitle: UILabel!
    
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

// MARK: Data
extension MovieDetailHeaderCell {
    
    func setup(title: String, backdropUrl: String?, posterUrl: String?) {
        
        movieTitle.text = title
        
        guard let backdropImageUrl = backdropUrl,
              let posterImageUrl = posterUrl,
              let backdropResourceUrl = URL(string: backdropImageUrl),
              let posterResourceUrl = URL(string: posterImageUrl) else {
                
            backdropImage.image = Image.AppIconWhite.image()
            posterImage.image = Image.AppIconWhite.image()
            return
        }
        
        let backdropPlaceholder = Image.AppIconWhite.image()
        let posterPlaceholder = Image.AppIconWhite.image()
        
        let backdropResource = ImageResource(downloadURL: backdropResourceUrl, cacheKey: backdropImageUrl)
        let posterResource = ImageResource(downloadURL: posterResourceUrl, cacheKey: posterImageUrl)
        
        let options: [KingfisherOptionsInfoItem] = [.transition(.fade(0.5)), .cacheOriginalImage]
        
        backdropImage.kf.setImage(
            with: backdropResource,
            placeholder: backdropPlaceholder,
            options: options,
            progressBlock: nil,
            completionHandler: { _ in })
        
        posterImage.kf.setImage(
            with: posterResource,
            placeholder: posterPlaceholder,
            options: options,
            progressBlock: nil,
            completionHandler: { _ in })
    }
}

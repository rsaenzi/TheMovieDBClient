//
//  MovieCatalogCell.swift
//  TheMovieDBClient
//
//  Created by Rigoberto Saenz Imbacuan on 7/21/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCatalogCell: UICollectionViewCell {
    
    // MARK: Outlets
    @IBOutlet private weak var posterImage: UIImageView!
    @IBOutlet private weak var movieTitle: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var releaseDate: UILabel!
    
    override init(frame: CGRect) { // From Code
        super.init(frame: frame)
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
extension MovieCatalogCell {
    
    func setup(for movie: MovieResult) {
        
        movieTitle.text = movie.title
        ratingLabel.text = String(movie.voteAverage)
        releaseDate.text = String(movie.releaseDate.prefix(4))
        
        guard let posterImageUrl = movie.getPosterPathImage(),
              let posterResourceUrl = URL(string: posterImageUrl) else {
            
            posterImage.image = Image.AppIconWhite.image()
            return
        }
        
        let posterPlaceholder = Image.AppIconWhite.image()
        let posterResource = ImageResource(downloadURL: posterResourceUrl, cacheKey: posterImageUrl)
        let options: [KingfisherOptionsInfoItem] = [.transition(.fade(0.5)), .cacheOriginalImage]
        
        posterImage.kf.setImage(
            with: posterResource,
            placeholder: posterPlaceholder,
            options: options,
            progressBlock: nil,
            completionHandler: { _ in })
    }
}

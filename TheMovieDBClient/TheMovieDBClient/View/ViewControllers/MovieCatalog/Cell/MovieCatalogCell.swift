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
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    static func getNib() -> UINib {
        let nibName = className(some: self)
        return UINib(nibName: nibName, bundle: nil)
    }
}

// MARK: Data
extension MovieCatalogCell {
    
    func setup(for movie: MovieResult) {
        
        movieTitle.text = movie.title
        ratingLabel.text = String(movie.voteAverage)
        releaseDate.text = movie.releaseDate
        
        guard let imageUrl = movie.getPosterPathImage(),
              let resourceUrl = URL(string: imageUrl) else {
            
            posterImage.image = Image.AppIconWhite.image()
            return
        }
        
        let placeholder = Image.AppIconWhite.image()
        let resource = ImageResource(downloadURL: resourceUrl, cacheKey: imageUrl)
        let options: [KingfisherOptionsInfoItem] = [.transition(.fade(0.5)), .cacheOriginalImage]
        
        posterImage.kf.setImage(
            with: resource,
            placeholder: placeholder,
            options: options,
            progressBlock: nil,
            completionHandler: { _ in })
        
    }
}

// MARK: TableView
extension MovieCatalogCell {

    static func getReuseIdentifier() -> String {
        return className(some: self)
    }
}

private func className(some: Any) -> String {
    return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
}

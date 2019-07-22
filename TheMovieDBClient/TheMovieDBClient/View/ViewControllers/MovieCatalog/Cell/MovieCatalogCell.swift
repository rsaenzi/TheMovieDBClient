//
//  MovieCatalogCell.swift
//  TheMovieDBClient
//
//  Created by Rigoberto Saenz Imbacuan on 7/21/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

import UIKit

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
}

// MARK: Data
extension MovieCatalogCell {
    
    func setup(for movie: MovieResult) {
        movieTitle.text = movie.title
        ratingLabel.text = String(movie.voteAverage)
        releaseDate.text = movie.releaseDate
    }
}

// MARK: Identification
extension MovieCatalogCell {
    
    static func getNib() -> UINib {
        let nibName = className(some: self)
        return UINib(nibName: nibName, bundle: nil)
    }
    
    static func getReuseIdentifier() -> String {
        return className(some: self)
    }
}

private func className(some: Any) -> String {
    return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
}

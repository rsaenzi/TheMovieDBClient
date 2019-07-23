//
//  MovieDetailsVC.swift
//  TheMovieDBClient
//
//  Created by Rigoberto Saenz Imbacuan on 7/20/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

import UIKit
import Hero
import RxSwift
import RxCocoa
import KVNProgress
import Kingfisher

class MovieDetailsVC: UIViewController {
    
    // MARK: Outlets
    @IBOutlet private weak var backdropImage: UIImageView!
    @IBOutlet private weak var posterImage: UIImageView!
    
    
    
    // MARK: Presenter
    private let presenter = MovieDetailsPresenter()
    
    // MARK: Data
    private var movie: MovieResult?
    
    // MARK: Bindings
    private let bag = DisposeBag()
}

// MARK: Life Cycle
extension MovieDetailsVC {
    
    func setup(for movie: MovieResult) {
        self.movie = movie
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO Subscribe to presenter
//        presenter.getMovieDetails(for: movie.id)
        
        guard let backdropImageUrl = movie?.getBackdropPathImage(),
              let backdropResourceUrl = URL(string: backdropImageUrl),
              let posterImageUrl = movie?.getPosterPathImage(),
              let posterResourceUrl = URL(string: posterImageUrl) else {
                
            backdropImage.image = Image.AppIconWhite.image()
            posterImage.image = Image.AppIconWhite.image()
            return
        }
        
        let backdropPlaceholder = Image.AppIconWhite.image()
        let backdropResource = ImageResource(downloadURL: backdropResourceUrl, cacheKey: backdropImageUrl)
        
        let posterPlaceholder = Image.AppIconWhite.image()
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

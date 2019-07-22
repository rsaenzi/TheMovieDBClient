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

class MovieDetailsVC: UIViewController {
    
    // MARK: Presenter
    private let presenter = MovieDetailsPresenter()
    
    // MARK: Bindings
    private let bag = DisposeBag()
}

// MARK: Life Cycle
extension MovieDetailsVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func setup(for movie: MovieResult) {
        
        // TODO Subscribe to presenter
        presenter.getMovieDetails(for: movie.id)
    }
}

//
//  MovieCatalogVC.swift
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

class MovieCatalogVC: UIViewController {
    
    // MARK: Presenter
    private let presenter = MovieCatalogPresenter()
    
    // MARK: Bindings
    private let bag = DisposeBag()
}

// MARK: Life Cycle
extension MovieCatalogVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Title
        let titleView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        titleView.contentMode = .scaleAspectFit
        titleView.image = Image.AppIconWhite.image()
        navigationItem.titleView = titleView
        
        presenter.getPopularMovies()
    }
    
    // TODO: Temporal
    @IBAction func onTapMovieInfo(_ sender: UIButton, forEvent event: UIEvent) {
        
        let screen: MovieDetailsVC = loadViewController()
        navigationController?.pushViewController(screen, animated: true)
    }
}

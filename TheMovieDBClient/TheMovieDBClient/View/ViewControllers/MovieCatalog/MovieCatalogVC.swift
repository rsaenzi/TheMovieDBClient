//
//  MovieCatalogVC.swift
//  TheMovieDBClient
//
//  Created by Rigoberto Saenz Imbacuan on 7/20/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

import UIKit
import Hero

class MovieCatalogVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Title
        let titleView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        titleView.contentMode = .scaleAspectFit
        titleView.image = Image.AppIconWhite.image()
        navigationItem.titleView = titleView   
    }
    
    @IBAction func onTapMovieInfo(_ sender: UIButton, forEvent event: UIEvent) {
        
        let screen: MovieInfoVC = loadViewController()
        navigationController?.pushViewController(screen, animated: true)
    }
}

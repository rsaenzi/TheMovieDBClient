//
//  WelcomeVC.swift
//  TheMovieDBClient
//
//  Created by Rigoberto Saenz Imbacuan on 7/20/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            
            let screen = MovieCatalogVC.loadFirstViewController()
            self.present(screen, animated: true, completion: nil)
        }
    }
}

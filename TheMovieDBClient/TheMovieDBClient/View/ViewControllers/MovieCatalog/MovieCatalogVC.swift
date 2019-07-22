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
    
    // MARK: Outlets
    @IBOutlet private weak var stateContainer: UIView!
    @IBOutlet private var stateViews: [UIView]!
    @IBOutlet private weak var grid: UICollectionView!
    
    // MARK: Cell Size
    private let cellWidth = UIScreen.main.bounds.width / 2
    private let cellHeight = (UIScreen.main.bounds.width / 2) * 1.5
    
    // MARK: Presenter
    private let presenter = MovieCatalogPresenter()
    
    // MARK: Bindings
    private let bag = DisposeBag()
}

// MARK: Life Cycle
extension MovieCatalogVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        
        // Icon on Navigation Bar
        let titleView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        titleView.contentMode = .scaleAspectFit
        titleView.image = Image.AppIconWhite.image()
        navigationItem.titleView = titleView
        
        // Cell Registration
        grid.register(MovieCatalogCell.getNib(),
                      forCellWithReuseIdentifier: MovieCatalogCell.getReuseIdentifier())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getPopularMovies()
    }
}

// MARK: Bindings
extension MovieCatalogVC {

    private func setupBindings() {
        
        presenter.state
            .subscribe { [weak self] state in
                guard let `self` = self else { return }
                
                self.hideAllContainers()
                self.showContainer(for: state.element!)
                
            }.disposed(by: bag)
    }
}

// MARK: Containers
extension MovieCatalogVC {
    
    private func hideAllContainers() {
        for item in stateViews {
            item.isHidden = true
        }
    }
    
    private func showContainer(for state: MovieCatalogState) {
        
        switch state {
        case .noData:
            KVNProgress.dismiss()
            stateContainer.viewWithTag(1)?.isHidden = false
            
        case .fetchingData:
            KVNProgress.show()
            stateContainer.viewWithTag(2)?.isHidden = false
            
        case .dataAvailable:
            grid.reloadData()
            KVNProgress.dismiss()
            stateContainer.viewWithTag(3)?.isHidden = false
            
        case .noInternet:
            KVNProgress.dismiss()
            stateContainer.viewWithTag(4)?.isHidden = false
            
        case .error(let key):
            KVNProgress.showError(withStatus: Language.get(key))
            stateContainer.viewWithTag(5)?.isHidden = false
        }
    }
}

// MARK: Collection View
extension MovieCatalogVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension MovieCatalogVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getMoviesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: MovieCatalogCell = collectionView.dequeue(indexPath)
        let movie = presenter.getMovie(for: indexPath)
        
        cell.setup(for: movie)
        return cell
    }
}

extension MovieCatalogVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let screen: MovieDetailsVC = loadViewController()
        let movie = presenter.getMovie(for: indexPath)
        
        screen.setup(for: movie)
        navigationController?.pushViewController(screen, animated: true)
    }
}

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
    @IBOutlet private weak var table: UITableView!
    
    // MARK: Presenter
    private var presenter: MovieDetailsPresenter!
    
    // MARK: Data
    private var movie: MovieResult!
    
    // MARK: Bindings
    private let bag = DisposeBag()
}

// MARK: Life Cycle
extension MovieDetailsVC {
    
    func setup(for movie: MovieResult) {
        self.movie = movie
        title = movie.title
        presenter = MovieDetailsPresenter(movie: movie)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        setupBindings()
        presenter.getMovieDetails(for: movie.id)
    }
}

// MARK: Bindings
extension MovieDetailsVC {
    
    private func setupBindings() {
        
        presenter.state
            .subscribe { [weak self] state in
                guard let `self` = self else { return }
                switch state.element! {

                case .success(let newIndexPaths):
                    self.table.reloadData()
                    
                    // TODO change reloadData for AddRows
//                    self.table.insertRows(at: newIndexPaths, with: UITableView.RowAnimation.automatic)

                default:
                    break
                }
            }.disposed(by: bag)
    }
}

// MARK: Internals
extension MovieDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
    private func registerCells() {
        table.register(MovieDetailHeaderCell.self, forCellReuseIdentifier: MovieDetailHeaderCell.getReuseIdentifier())
        table.register(MovieDetailRatingCell.self, forCellReuseIdentifier: MovieDetailRatingCell.getReuseIdentifier())
        table.register(MovieDetailTaglineCell.self, forCellReuseIdentifier: MovieDetailTaglineCell.getReuseIdentifier())
        table.register(MovieDetailOverviewCell.self, forCellReuseIdentifier: MovieDetailOverviewCell.getReuseIdentifier())
        table.register(MovieDetailHomepageCell.self, forCellReuseIdentifier: MovieDetailHomepageCell.getReuseIdentifier())
        table.register(MovieDetailImdbCell.self, forCellReuseIdentifier: MovieDetailImdbCell.getReuseIdentifier())
        table.register(MovieDetailGenreCell.self, forCellReuseIdentifier: MovieDetailGenreCell.getReuseIdentifier())
        table.register(MovieDetailOriginalCell.self, forCellReuseIdentifier: MovieDetailOriginalCell.getReuseIdentifier())
        table.register(MovieDetailProductionCell.self, forCellReuseIdentifier: MovieDetailProductionCell.getReuseIdentifier())
        table.register(MovieDetailCountryCell.self, forCellReuseIdentifier: MovieDetailCountryCell.getReuseIdentifier())
        table.register(MovieDetailRevenueCell.self, forCellReuseIdentifier: MovieDetailRevenueCell.getReuseIdentifier())
        table.register(MovieDetailBudgetCell.self, forCellReuseIdentifier: MovieDetailBudgetCell.getReuseIdentifier())
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let detailItem = presenter.getDetailItem(at: indexPath)
        
        switch detailItem {

        case .header(let title, let backdropImage, let posterImage):
            let cell: MovieDetailHeaderCell = tableView.dequeue(indexPath)
            cell.setup(title: title, backdropUrl: backdropImage, posterUrl: posterImage)
            return cell

        case .rating(let rating, let releaseDate):
            let cell: MovieDetailRatingCell = tableView.dequeue(indexPath)
            cell.setup(rating: rating, releaseDate: releaseDate)
            return cell
            
        case .tagline(let tagline):
            let cell: MovieDetailTaglineCell = tableView.dequeue(indexPath)
            cell.setup(tagline: tagline)
            return cell
            
        case .overview(let overview):
            let cell: MovieDetailOverviewCell = tableView.dequeue(indexPath)
            cell.setup(overview: overview)
            return cell
            
        case .homepage(let homepage):
            let cell: MovieDetailHomepageCell = tableView.dequeue(indexPath)
            cell.setup(homepage: homepage)
            return cell
            
        case .imdb(let imdbId):
            let cell: MovieDetailImdbCell = tableView.dequeue(indexPath)
            cell.setup(imdbId: imdbId)
            return cell
            
        case .genre(let genre):
            let cell: MovieDetailGenreCell = tableView.dequeue(indexPath)
            cell.setup(genre: genre)
            return cell
            
        case .original(let title):
            let cell: MovieDetailOriginalCell = tableView.dequeue(indexPath)
            cell.setup(title: title)
            return cell
            
        case .production(let company):
            let cell: MovieDetailProductionCell = tableView.dequeue(indexPath)
            cell.setup(company: company)
            return cell
            
        case .country(let country):
            let cell: MovieDetailCountryCell = tableView.dequeue(indexPath)
            cell.setup(country: country)
            return cell
            
        case .revenue(let revenue):
            let cell: MovieDetailRevenueCell = tableView.dequeue(indexPath)
            cell.setup(revenue: revenue)
            return cell
            
        case .budget(let budget):
            let cell: MovieDetailBudgetCell = tableView.dequeue(indexPath)
            cell.setup(budget: budget)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let detailItem = presenter.getDetailItem(at: indexPath)
        
        switch detailItem {
            
        case .header:
            return UIScreen.main.bounds.width * 0.8
            
        case .rating:
            return 45
            
        case .tagline:
            return 50
            
        case .overview:
            return 100 // TODO Calculate
            
        case .homepage:
            return 35
            
        case .imdb:
            return 35
            
        case .genre:
            return 40 // TODO Calculate
            
        case .original:
            return 40 // TODO Calculate
            
        case .production:
            return 40 // TODO Calculate
            
        case .country:
            return 40 // TODO Calculate
            
        case .revenue:
            return 40 // TODO Calculate
            
        case .budget:
            return 40 // TODO Calculate
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailItem = presenter.getDetailItem(at: indexPath)
        
        switch detailItem {
            
        case .homepage(let homepage):
            open(homepage: homepage)
            
        case .imdb(let imdbId):
            open(imdbId: imdbId)
        
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getAllDetailItemsCount()
    }
}

// MARK: Internals
extension MovieDetailsVC {
    
    private func open(homepage: String?) {
        
        if let page = homepage, let url = URL(string: page),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    private func open(imdbId: String?) {

        if let id = imdbId, let url = URL(string: "\(ApiCredentials.imdbUrl)\(id)"),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

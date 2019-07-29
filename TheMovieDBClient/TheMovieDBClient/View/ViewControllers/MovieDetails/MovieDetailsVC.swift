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
        table.register(MovieDetailHeaderCell.getNib(), forCellReuseIdentifier: MovieDetailHeaderCell.getReuseIdentifier())
        table.register(MovieDetailRatingCell.getNib(), forCellReuseIdentifier: MovieDetailRatingCell.getReuseIdentifier())
        table.register(MovieDetailTaglineCell.getNib(), forCellReuseIdentifier: MovieDetailTaglineCell.getReuseIdentifier())
        table.register(MovieDetailOverviewCell.getNib(), forCellReuseIdentifier: MovieDetailOverviewCell.getReuseIdentifier())
        table.register(MovieDetailHomepageCell.getNib(), forCellReuseIdentifier: MovieDetailHomepageCell.getReuseIdentifier())
        table.register(MovieDetailImdbCell.getNib(), forCellReuseIdentifier: MovieDetailImdbCell.getReuseIdentifier())
        table.register(MovieDetailGenreCell.getNib(), forCellReuseIdentifier: MovieDetailGenreCell.getReuseIdentifier())
        table.register(MovieDetailOriginalCell.getNib(), forCellReuseIdentifier: MovieDetailOriginalCell.getReuseIdentifier())
        table.register(MovieDetailProductionCell.getNib(), forCellReuseIdentifier: MovieDetailProductionCell.getReuseIdentifier())
        table.register(MovieDetailCountryCell.getNib(), forCellReuseIdentifier: MovieDetailCountryCell.getReuseIdentifier())
        table.register(MovieDetailRevenueCell.getNib(), forCellReuseIdentifier: MovieDetailRevenueCell.getReuseIdentifier())
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let detailItem = presenter.getDetailItem(at: indexPath)
        
        switch detailItem {

        case .header(let title, let backdropImage, let posterImage):
            let cell: MovieDetailHeaderCell = tableView.dequeue(indexPath)
            cell.setup(title: title, backdropImage: backdropImage, posterImage: posterImage)
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
            
        case .revenue(let budget, let revenue):
            let cell: MovieDetailRevenueCell = tableView.dequeue(indexPath)
            cell.setup(budget: budget, revenue: revenue)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let detailItem = presenter.getDetailItem(at: indexPath)
        
        switch detailItem {
            
        case .header:
            return UIScreen.main.bounds.width * 0.8
            
        case .rating:
            return 50
            
        case .tagline:
            return 50
            
        case .overview:
            return 50
            
        case .homepage:
            return 50
            
        case .imdb:
            return 50
            
        case .genre:
            return 50
            
        case .original:
            return 50
            
        case .production:
            return 50
            
        case .country:
            return 50
            
        case .revenue:
            return 50
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

        if let id = imdbId, let url = URL(string: "https://m.imdb.com/title/\(id)"),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
//    private func loadMainInfo(from movie: MovieResult) {
//
//        title = movie.title
//        movieTitle.text = movie.title
//        rating.text = String(movie.voteAverage)
//        releaseDate.text = String(movie.releaseDate)
//        overview.text = movie.overview
//
//        guard let backdropImageUrl = movie.getBackdropPathImage(),
//            let backdropResourceUrl = URL(string: backdropImageUrl),
//            let posterImageUrl = movie.getPosterPathImage(),
//            let posterResourceUrl = URL(string: posterImageUrl) else {
//
//                backdropImage.image = Image.AppIconWhite.image()
//                posterImage.image = Image.AppIconWhite.image()
//                return
//        }
//
//        let backdropPlaceholder = Image.AppIconWhite.image()
//        let backdropResource = ImageResource(downloadURL: backdropResourceUrl, cacheKey: backdropImageUrl)
//
//        let posterPlaceholder = Image.AppIconWhite.image()
//        let posterResource = ImageResource(downloadURL: posterResourceUrl, cacheKey: posterImageUrl)
//
//        let options: [KingfisherOptionsInfoItem] = [.transition(.fade(0.5)), .cacheOriginalImage]
//
//        backdropImage.kf.setImage(
//            with: backdropResource,
//            placeholder: backdropPlaceholder,
//            options: options,
//            progressBlock: nil,
//            completionHandler: { _ in })
//
//        posterImage.kf.setImage(
//            with: posterResource,
//            placeholder: posterPlaceholder,
//            options: options,
//            progressBlock: nil,
//            completionHandler: { _ in })
//    }
    
//    private func loadOptionalInfo(from movie: MovieDetails) {
//
//        tagline.text = movie.tagline
//    }
}

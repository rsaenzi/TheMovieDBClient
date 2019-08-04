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
import Kingfisher

class MovieDetailsVC: UIViewController {
    
    // MARK: Outlets
    @IBOutlet private weak var table: UITableView!
    
    // MARK: Presenter
    private var presenter: MovieDetailsPresenter!
    
    // MARK: Data
    private var taglineCellHeight: CGFloat = 0
    private var overviewCellHeight: CGFloat = 0
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
                    self.table.insertRows(at: newIndexPaths, with: .fade)

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
        table.register(MovieDetailReleaseCell.self, forCellReuseIdentifier: MovieDetailReleaseCell.getReuseIdentifier())
        table.register(MovieDetailTaglineCell.self, forCellReuseIdentifier: MovieDetailTaglineCell.getReuseIdentifier())
        table.register(MovieDetailOverviewCell.self, forCellReuseIdentifier: MovieDetailOverviewCell.getReuseIdentifier())
        table.register(MovieDetailHomepageCell.self, forCellReuseIdentifier: MovieDetailHomepageCell.getReuseIdentifier())
        table.register(MovieDetailImdbCell.self, forCellReuseIdentifier: MovieDetailImdbCell.getReuseIdentifier())
        table.register(MovieDetailGenreCell.self, forCellReuseIdentifier: MovieDetailGenreCell.getReuseIdentifier())
        table.register(MovieDetailGenreTitleCell.self, forCellReuseIdentifier: MovieDetailGenreTitleCell.getReuseIdentifier())
        table.register(MovieDetailOriginalCell.self, forCellReuseIdentifier: MovieDetailOriginalCell.getReuseIdentifier())
        table.register(MovieDetailCompanyCell.self, forCellReuseIdentifier: MovieDetailCompanyCell.getReuseIdentifier())
        table.register(MovieDetailCompanyTitleCell.self, forCellReuseIdentifier: MovieDetailCompanyTitleCell.getReuseIdentifier())
        table.register(MovieDetailCountryCell.self, forCellReuseIdentifier: MovieDetailCountryCell.getReuseIdentifier())
        table.register(MovieDetailCountryTitleCell.self, forCellReuseIdentifier: MovieDetailCountryTitleCell.getReuseIdentifier())
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

        case .rating(let rating, let count):
            let cell: MovieDetailRatingCell = tableView.dequeue(indexPath)
            cell.setup(rating: rating, count: count)
            return cell
            
        case .release(let releaseDate):
            let cell: MovieDetailReleaseCell = tableView.dequeue(indexPath)
            cell.setup(releaseDate: releaseDate)
            return cell
            
        case .tagline(let tagline):
            let cell: MovieDetailTaglineCell = tableView.dequeue(indexPath)
            cell.setup(tagline: tagline)
            taglineCellHeight = cell.calculateCellHeight()
            return cell
            
        case .overview(let overview):
            let cell: MovieDetailOverviewCell = tableView.dequeue(indexPath)
            cell.setup(overview: overview)
            overviewCellHeight = cell.calculateCellHeight()
            return cell
            
        case .homepage(let homepage):
            let cell: MovieDetailHomepageCell = tableView.dequeue(indexPath)
            cell.setup(homepage: homepage)
            return cell
            
        case .imdb(let imdbUrl):
            let cell: MovieDetailImdbCell = tableView.dequeue(indexPath)
            cell.setup(imdbUrl: imdbUrl)
            return cell

        case .genreTitle(let title):
            let cell: MovieDetailGenreTitleCell = tableView.dequeue(indexPath)
            cell.setup(title: title)
            return cell
            
        case .genre(let genre):
            let cell: MovieDetailGenreCell = tableView.dequeue(indexPath)
            cell.setup(genre: genre)
            return cell
            
        case .original(let title, let language):
            let cell: MovieDetailOriginalCell = tableView.dequeue(indexPath)
            cell.setup(title: title, language: language)
            return cell

        case .companyTitle:
            let cell: MovieDetailCompanyTitleCell = tableView.dequeue(indexPath)
            return cell
            
        case .company(let company, let logoPath, let originCountry):
            let cell: MovieDetailCompanyCell = tableView.dequeue(indexPath)
            cell.setup(name: company, logoPath: logoPath, originCountry: originCountry)
            return cell

        case .countryTitle:
            let cell: MovieDetailCountryTitleCell = tableView.dequeue(indexPath)
            return cell
            
        case .country(let country, let isoCode):
            let cell: MovieDetailCountryCell = tableView.dequeue(indexPath)
            cell.setup(country: country, isoCode: isoCode)
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
            return (UIScreen.main.bounds.width * 0.8) + 8
            
        case .tagline:
            return taglineCellHeight
            
        case .homepage:
            return 40
            
        case .overview:
            return overviewCellHeight
            
        case .rating, .release:
            return 35
            
        case .genreTitle, .companyTitle, .countryTitle:
            return 30
            
            
        case .genre, .country:
            return 28
            
        case .company:
            return 40
        
        case .original:
            return 58
            
        case .revenue, .budget:
            return 35
            
        case .imdb:
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailItem = presenter.getDetailItem(at: indexPath)
        
        switch detailItem {
            
        case .homepage(let homepage):
            open(homepage: homepage)
            
        case .imdb(let imdbUrl):
            open(imdbUrl: imdbUrl)
        
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
    
    private func open(imdbUrl: String?) {

        if let validUrl = imdbUrl, let url = URL(string: validUrl),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

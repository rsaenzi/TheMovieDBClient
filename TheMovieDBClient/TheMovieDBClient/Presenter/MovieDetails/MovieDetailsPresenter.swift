//
//  MovieDetailsPresenter.swift
//  TheMovieDBClient
//
//  Created by Rigoberto Saenz Imbacuan on 7/20/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

import RxSwift

class MovieDetailsPresenter {
    
    // MARK: Bindings
    let state = PublishSubject<MovieDetailsState>()
    
    // MARK: Interactor
    private let getMovieDetailsInteractor = GetMovieDetailsInteractor()
    
    // MARK: Data
    private var detailItems = [MovieDetailItem]()
    
    // MARK: Formatting
    private var dollarCurrency: NumberFormatter
    
    // MARK: Bindings
    private let bag = DisposeBag()
    
    
    // MARK: Life Cycle
    public init(movie: MovieResult) {
        
        dollarCurrency = NumberFormatter()
        dollarCurrency.locale = Locale(identifier: "en_US")
        dollarCurrency.numberStyle = .currency
        dollarCurrency.minimumFractionDigits = 0
        dollarCurrency.maximumFractionDigits = 0
        dollarCurrency.generatesDecimalNumbers = false
        
        setup(using: movie)
        setupBindings()
    }
}

// MARK: Init Logic
extension MovieDetailsPresenter {
    
    private func setup(using movie: MovieResult) {
        loadInfo(from: movie)
    }
    
    private func loadInfo(from movie: MovieResult) {
        
        detailItems = []
        detailItems.append(.header(title: movie.title, backdropImage: movie.getBackdropPathImage(), posterImage: movie.getPosterPathImage()))
    }
    
    private func loadDetails(from movie: MovieDetails) {
        
        if let tagline = movie.tagline, tagline.count > 0 {
            detailItems.append(.tagline(tagline: tagline))
        }

        if let homepage = movie.homepage, homepage.count > 0 {
            detailItems.append(.homepage(homepage: homepage))
        }

        if let overview = movie.overview, overview.count > 0 {
            detailItems.append(.overview(overview: overview))
        }
        
        detailItems.append(.rating(rating: movie.voteAverage, releaseDate: movie.releaseDate))

        for genre in movie.genres {
            detailItems.append(.genre(genre: genre))
        }

        detailItems.append(.original(title: movie.originalTitle))

        for company in movie.productionCompanies {
            detailItems.append(.production(company: company))
        }

        for country in movie.productionCountries {
            detailItems.append(.country(country: country))
        }
        
        if movie.revenue > 0, let revenueInDollars = dollarCurrency.string(from: NSNumber(value: movie.revenue)) {
            detailItems.append(.revenue(revenue: revenueInDollars))
        }

        if movie.budget > 0, let budgetInDollars = dollarCurrency.string(from: NSNumber(value: movie.budget)) {
            detailItems.append(.budget(budget: budgetInDollars))
        }
        
        if let imdbId = movie.imdbId, imdbId.count > 0 {
            detailItems.append(.imdb(imdbUrl: "\(ApiCredentials.imdbUrl)\(imdbId)"))
        }
    }
    
    private func getLoadedIndexPaths() -> [IndexPath] {
        let rows: [Int] = Array(1...detailItems.count - 1)
        let indexPaths = rows.map { row -> IndexPath in
            return IndexPath(row: row, section: 0)
        }
        return indexPaths
    }
}

// MARK: Bindings
extension MovieDetailsPresenter {
    
    private func setupBindings() {
        
        getMovieDetailsInteractor.bindResponse
            .subscribe { [weak self] response in
                guard let `self` = self else { return }
                self.process(response: response.element!)
            }.disposed(by: bag)
    }
}

// MARK: Actions
extension MovieDetailsPresenter {
    
    func getMovieDetails(for movieId: Int) {
        getMovieDetailsInteractor.request(movieId: movieId)
    }
    
    func getDetailItem(at indexPath: IndexPath) -> MovieDetailItem {
        return detailItems[indexPath.row]
    }
    
    func getAllDetailItemsCount() -> Int {
        return detailItems.count
    }
}

// MARK: Internals
extension MovieDetailsPresenter {
    
    private func process(response: GetMovieDetailsResponse) {
        
        switch response {
            
        case .success(let content):
            loadDetails(from: content)
            state.onNext(.success(newIndexPaths: getLoadedIndexPaths()))
            
        default:
            state.onNext(.error)
        }
    }
}

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
    
    // MARK: Bindings
    private let bag = DisposeBag()
    
    
    // MARK: Life Cycle
    public init(movie: MovieResult) {
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
        detailItems.append(.rating(rating: movie.voteAverage, releaseDate: movie.releaseDate))
    }
    
    private func loadDetails(from movie: MovieDetails) {
        
//        detailItems.append(.tagline(tagline: movie.tagline))
//        detailItems.append(.overview(overview: movie.overview))
//        detailItems.append(.homepage(homepage: movie.homepage))
//        detailItems.append(.imdb(imdbId: movie.imdbId))
//
//        for genre in movie.genres {
//            detailItems.append(.genre(genre: genre))
//        }
//
//        detailItems.append(.original(title: movie.originalTitle))
//
//        for company in movie.productionCompanies {
//            detailItems.append(.production(company: company))
//        }
//
//        for country in movie.productionCountries {
//            detailItems.append(.country(country: country))
//        }
//
//        detailItems.append(.revenue(budget: movie.budget, revenue: movie.revenue))
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
            state.onNext(.success(movie: content))
            
        default:
            state.onNext(.error)
        }
    }
}

//
//  MovieCatalogPresenter.swift
//  TheMovieDBClient
//
//  Created by Rigoberto Saenz Imbacuan on 7/20/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

import RxSwift

class MovieCatalogPresenter {
    
    // MARK: Bindings
    let state = BehaviorSubject<MovieCatalogState>(value: .noData)
    private var movies = [MovieResult]()
    
    // MARK: Interactors
    private let getConfigurationInteractor = GetConfigurationInteractor()
    private let getPopularMoviesInteractor = GetPopularMoviesInteractor()
    
    // MARK: Bindings
    private let bag = DisposeBag()
    
    // MARK: Pagination
    private var currentPage = 1
    private var totalPages = 1
    private var fetchingPage = false
    
    // MARK: Life Cycle
    public init() {
        setupBindings()
    }
}

// MARK: Getters
extension MovieCatalogPresenter {
    
    func getMoviesCount() -> Int {
        return movies.count
    }
    
    func getMovie(for indexPath: IndexPath) -> MovieResult {
        return movies[indexPath.row]
    }
}

// MARK: Bindings
extension MovieCatalogPresenter {
    
    private func setupBindings() {
        
        getConfigurationInteractor.bindResponse
            .subscribe { [weak self] response in
                guard let `self` = self else { return }
                self.process(response: response.element!)
            }.disposed(by: bag)
        
        getPopularMoviesInteractor.bindResponse
            .subscribe { [weak self] response in
                guard let `self` = self else { return }
                self.process(response: response.element!)
            }.disposed(by: bag)
    }
}

// MARK: Actions
extension MovieCatalogPresenter {

    func getPopularMovies() {
        
        state.onNext(.fetchingData)
        
        movies = []
        currentPage = 1
        
        fetchingPage = true
        
        if needsConfig() {
            getConfigurationInteractor.request()
        } else {
            getPopularMoviesInteractor.request(page: currentPage)
        }
    }
    
    func loadNextPage() {
        
        // Prevents calling the endpoint multiple times for the same page...
        if fetchingPage {
            return
        }
        
        // Prevents calling more pages than available...
        currentPage += 1
        if currentPage > totalPages {
            return
        }
        
        fetchingPage = true
        
        if needsConfig() {
            getConfigurationInteractor.request()
        } else {
            getPopularMoviesInteractor.request(page: currentPage)
        }
    }
}

// MARK: Internals
extension MovieCatalogPresenter {
    
    private func process(response: GetConfigurationResponse) {
        
        switch response {
            
        case .success(let content):
            
            // Save the required values to build the images full URL
            ApiCredentials.imageBaseUrl = content.images.secureBaseUrl
            
            // To improve performance we choose the smallest Image Size value
            ApiCredentials.imageBackdropSize = getSmallestValue(from: content.images.backdropSizes)
            ApiCredentials.imageLogoSize = getSmallestValue(from: content.images.logoSizes)
            ApiCredentials.imagePosterSize = getSmallestValue(from: content.images.posterSizes)
            ApiCredentials.imageProfileSize = getSmallestValue(from: content.images.profileSizes)
            ApiCredentials.imageStillSize = getSmallestValue(from: content.images.stillSizes)
            
            getPopularMoviesInteractor.request(page: currentPage)
            
        case .unauthorizedError:
            state.onNext(.error(key: .movieCatalogCredentialsError))
            
        case .serverError, .invalidResponseError:
            state.onNext(.error(key: .movieCatalogServerError))
            
        case .responseDataError, .redirectionError, .clientError, .jsonDecodingError:
            state.onNext(.error(key: .movieCatalogGeneralError))
            
        case .requestFailureError, .requestOfflineError, .requestTimeOutError:
            state.onNext(.noInternet)
        }
    }
    
    private func process(response: GetPopularMoviesResponse) {
        
        switch response {

        case .success(let content):
            
            // Save fetched movies
            if currentPage == 1 {
                movies = content.results
            } else {
                movies.append(contentsOf: content.results)
            }
            
            totalPages = content.totalPages
            fetchingPage = false
            
            state.onNext(.dataAvailable(movies: movies))
            
        case .unauthorizedError:
            state.onNext(.error(key: .movieCatalogCredentialsError))
            
        case .resourceNotFoundError, .serverError, .invalidResponseError:
            state.onNext(.error(key: .movieCatalogServerError))
            
        case .responseDataError, .redirectionError, .clientError, .jsonDecodingError:
            state.onNext(.error(key: .movieCatalogGeneralError))
            
        case .requestFailureError, .requestOfflineError, .requestTimeOutError:
            state.onNext(.noInternet)
        }
    }
    
    private func getSmallestValue(from stringValues: [String]) -> String {
        
        let intValues = stringValues
            .map { sizeItem -> String in
                return sizeItem.removeNonNumericCharacters()
                
            }.filter { item -> Bool in
                return item.count > 0
                
            }.map { item -> Int in
                return Int(item)!
            }
        
        guard let min = intValues.min() else {
            return ""
        }
        
        return "w\(min)"
    }
    
    private func needsConfig() -> Bool {
        
        guard let _ = ApiCredentials.imageBaseUrl,
              let _ = ApiCredentials.imageBackdropSize,
              let _ = ApiCredentials.imageLogoSize,
              let _ = ApiCredentials.imagePosterSize,
              let _ = ApiCredentials.imageProfileSize,
              let _ = ApiCredentials.imageStillSize else {
            return true
        }
        return false
    }
}

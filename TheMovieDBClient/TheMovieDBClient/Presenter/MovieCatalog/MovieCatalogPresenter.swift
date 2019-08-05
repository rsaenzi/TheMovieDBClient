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
    private let bag = DisposeBag()
    
    // MARK: Interactors
    private let getConfigurationInteractor = GetConfigurationInteractor()
    private let getPopularMoviesInteractor = GetPopularMoviesInteractor()
    
    // MARK: Pagination
    private var currentPage = 1
    private var totalPages = 1
    private var fetchingPage = false
    
    // MARK: Image Quality
    private let useLowResImages = true
    
    // MARK: Data
    private var movies = [MovieResult]()
    
    
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
    
    func reset() {
        movies = []
        currentPage = 1
        fetchingPage = false
    }

    func getMoviesFirstPage() {
        
        // Prevents calling the endpoint multiple times for the same page...
        if fetchingPage {
            return
        }
        
        // Prevents to call the first page multiple times...
        if movies.count > 0 {
            return
        }
        
        movies = []
        currentPage = 1
        
        fetchingPage = true
        state.onNext(.fetchingData)
        
        if needsConfig() {
            getConfigurationInteractor.request()
        } else {
            getPopularMoviesInteractor.request(page: currentPage)
        }
    }
    
    func getMoviesNextPage() {
        
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
            ApiCredentials.imageBackdropSize = getSmallSize(from: content.images.backdropSizes)
            ApiCredentials.imageLogoSize = getSmallSize(from: content.images.logoSizes)
            ApiCredentials.imagePosterSize = getSmallSize(from: content.images.posterSizes)
            ApiCredentials.imageProfileSize = getSmallSize(from: content.images.profileSizes)
            ApiCredentials.imageStillSize = getSmallSize(from: content.images.stillSizes)
            
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
            
            // Remove any movie that does not have poster or backdrop images
            let newMovies = content.results.filter { movieItem -> Bool in
                
                guard let _ = movieItem.getBackdropPathImage(),
                      let _ = movieItem.getPosterPathImage() else {
                    return false
                }
                return true
            }
            
            // Save fetched movies
            if currentPage == 1 {
                movies = newMovies
            } else {
                movies.append(contentsOf: newMovies)
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
    
    private func getSmallSize(from stringSizes: [String]) -> String {
        
        let intSizes = stringSizes
            
            // Remove non numeric chars
            .map { item -> String in
                return item.removeNonNumericCharacters()
                
            // Remove empty strings
            }.filter { item -> Bool in
                return item.count > 0
                
            // Convert to an array of Ints
            }.map { item -> Int in
                return Int(item)!
            
            // Sort them in ascending order
            }.sorted { first, second -> Bool in
                return first < second
            }
        
        if useLowResImages == false {

            // First we try to get the size next to the smallest one...
            if intSizes.count >= 2 {
                
                let selectedSize = intSizes[intSizes.count - 2]
                return "w\(selectedSize)"
            }
        }
        
        // If not possible, we choose the smallest size
        guard let min = intSizes.min() else {
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

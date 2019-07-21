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
    
    // MARK: Interactor
    private let getPopularMoviesInteractor = GetPopularMoviesInteractor()
    
    // MARK: Bindings
    private let bag = DisposeBag()
    
    
    // MARK: Life Cycle
    public init() {
        setupBindings()
    }
}

// MARK: Bindings
extension MovieCatalogPresenter {
    
    private func setupBindings() {
        
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
        getPopularMoviesInteractor.request()
    }
}

// MARK: Internals
extension MovieCatalogPresenter {
    
    private func process(response: GetPopularMoviesResponse) {
        
        switch response {

        case .success(let content):
            state.onNext(.dataAvailable(movies: content.results))
            
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
}

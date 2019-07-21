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
    let state = BehaviorSubject<MovieDetailsState>(value: .noData)
    
    // MARK: Interactor
    private let getMovieDetailsInteractor = GetMovieDetailsInteractor()
    
    // MARK: Bindings
    private let bag = DisposeBag()
    
    
    // MARK: Life Cycle
    public init() {
        setupBindings()
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
        state.onNext(.fetchingData)
        getMovieDetailsInteractor.request(movieId: movieId)
    }
}

// MARK: Internals
extension MovieDetailsPresenter {
    
    private func process(response: GetMovieDetailsResponse) {
        
        switch response {
            
        case .success(let content):
            state.onNext(.dataAvailable(movie: content))
            
        case .unauthorizedError:
            state.onNext(.error(key: .movieDetailsCredentialsError))
            
        case .resourceNotFoundError, .serverError, .invalidResponseError:
            state.onNext(.error(key: .movieDetailsServerError))
            
        case .responseDataError, .redirectionError, .clientError, .jsonDecodingError:
            state.onNext(.error(key: .movieDetailsGeneralError))
            
        case .requestFailureError, .requestOfflineError, .requestTimeOutError:
            state.onNext(.noInternet)
        }
    }
}

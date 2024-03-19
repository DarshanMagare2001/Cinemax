//
//  SeeAllVCInteractor.swift
//  Cinemax
//
//  Created by IPS-161 on 19/03/24.
//

import Foundation
import RxSwift

enum SeeAllVCInputs {
    case fetchMovieUpcoming
    case fetchMovieNowPlaying
    case fetchMovieTopRated
    case fetchMoviePopular
    case fetchMovieSimilar
    case fetchMovieSearch
}

protocol SeeAllVCInteractorProtocol {
    func fetchAllMoviesPagewise(seeAllVCInputs:SeeAllVCInputs?,movieId:Int?,searchText:String?,page: Int?) -> Single<[MasterMovieModelResult]>
}

class SeeAllVCInteractor {
    var movieServiceManager: MoviesServiceManagerProtocol
    let disposeBag = DisposeBag()
    init(movieServiceManager: MoviesServiceManagerProtocol){
        self.movieServiceManager = movieServiceManager
    }
}

extension SeeAllVCInteractor: SeeAllVCInteractorProtocol  {
    func fetchAllMoviesPagewise(seeAllVCInputs:SeeAllVCInputs?,movieId:Int?,searchText:String?,page: Int?) -> Single<[MasterMovieModelResult]> {
        return Single.create { (single) -> Disposable in
            let disposable = Disposables.create()
            guard let seeAllVCInputs = seeAllVCInputs,
                  let movieId = movieId,
                  let searchText = searchText,
                  let page = page else {
                      single(.failure(fatalError()))
                      return disposable
                  }
            switch seeAllVCInputs {
                
            case .fetchMovieUpcoming:
                self.movieServiceManager.fetchMovieUpcoming(page: page)
                    .subscribe({ data in
                        switch data {
                        case.success(let movieData):
                            single(.success(movieData.results))
                        case.failure(let error):
                            single(.failure(error))
                        }
                    }).disposed(by: self.disposeBag)
                
            case .fetchMovieNowPlaying:
                self.movieServiceManager.fetchMovieNowPlaying(page: page)
                    .subscribe({ data in
                        switch data {
                        case.success(let movieData):
                            single(.success(movieData.results))
                        case.failure(let error):
                            single(.failure(error))
                        }
                    }).disposed(by: self.disposeBag)
                
            case .fetchMovieTopRated:
                self.movieServiceManager.fetchMovieTopRated(page: page)
                    .subscribe({ data in
                        switch data {
                        case.success(let movieData):
                            single(.success(movieData.results))
                        case.failure(let error):
                            single(.failure(error))
                        }
                    }).disposed(by: self.disposeBag)
                
            case .fetchMoviePopular:
                self.movieServiceManager.fetchMoviePopular(page: page)
                    .subscribe({ data in
                        switch data {
                        case.success(let movieData):
                            single(.success(movieData.results))
                        case.failure(let error):
                            single(.failure(error))
                        }
                    }).disposed(by: self.disposeBag)
                
            case .fetchMovieSimilar:
                self.movieServiceManager.fetchMovieSimilar(movieId: movieId, page: page)
                    .subscribe({ data in
                        switch data {
                        case.success(let movieData):
                            single(.success(movieData.results ?? []))
                        case.failure(let error):
                            single(.failure(error))
                        }
                    }).disposed(by: self.disposeBag)
                
            case .fetchMovieSearch:
                self.movieServiceManager.fetchMovieSearch(searchText: searchText, page: page)
                    .subscribe({ data in
                        switch data {
                        case.success(let movieData):
                            single(.success(movieData.results ?? []))
                        case.failure(let error):
                            single(.failure(error))
                        }
                    }).disposed(by: self.disposeBag)
                
            }
            return disposable
        }
    }
    
}
//
//  SeeAllVCInteractor.swift
//  Cinemax
//
//  Created by IPS-161 on 19/03/24.
//

import Foundation
import RxSwift

//enum SeeAllVCInputs:String {
//    case fetchMovieUpcoming = "UPCOMING"
//    case fetchMovieNowPlaying = "NOWPLAYING"
//    case fetchMovieTopRated = "TOPRATED"
//    case fetchMoviePopular = "POPULAR"
//    case fetchMovieSimilar = "SimilarMovies"
//    case fetchMovieSearch = "Search"
//    case fetchMoviesByGenres = "Genres"
//}

enum SeeAllVCInputs {
    case fetchMovieUpcoming(title:String)
    case fetchMovieNowPlaying(title:String)
    case fetchMovieTopRated(title:String)
    case fetchMoviePopular(title:String)
    case fetchMovieSimilar(title:String)
    case fetchMovieSearch(title:String)
    case fetchMoviesByGenres(title:String)
}


protocol SeeAllVCInteractorProtocol {
    func fetchAllMoviesPagewise(seeAllVCInputs:SeeAllVCInputs?,movieId:Int?,searchText:String?,page: Int?,genreId:Int?) -> Single<[MasterMovieModelResult]>
    func fetchAllMoviesPagewiseInDetail(movies:[MasterMovieModelResult]) -> Single<[MovieDetailsModel]>
}

class SeeAllVCInteractor {
    var movieServiceManager: MoviesServiceManagerProtocol
    let disposeBag = DisposeBag()
    init(movieServiceManager: MoviesServiceManagerProtocol){
        self.movieServiceManager = movieServiceManager
    }
}

extension SeeAllVCInteractor: SeeAllVCInteractorProtocol  {
    func fetchAllMoviesPagewise(seeAllVCInputs:SeeAllVCInputs?,movieId:Int?,searchText:String?,page: Int?,genreId:Int?) -> Single<[MasterMovieModelResult]> {
        return Single.create { (single) -> Disposable in
            let disposable = Disposables.create()
            guard let seeAllVCInputs = seeAllVCInputs,
                  let movieId = movieId,
                  let searchText = searchText,
                  let page = page,
                  let genreId = genreId else {
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
                
            case .fetchMoviesByGenres:
                self.movieServiceManager.fetchMoviesByGenres(genreId: genreId, page: page)
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
    
    func fetchAllMoviesPagewiseInDetail(movies:[MasterMovieModelResult]) -> Single<[MovieDetailsModel]> {
        return Single.create { (single) -> Disposable in
            let disposable = Disposables.create()
            var tempArray = [MovieDetailsModel]()
            let dispatchGroup = DispatchGroup()
            for movie in movies {
                dispatchGroup.enter()
                self.movieServiceManager.fetchMovieDetail(movieId: movie.id ?? 0)
                    .subscribe(onSuccess: { movieDetails in
                        tempArray.append(movieDetails)
                        dispatchGroup.leave()
                    }, onFailure: { error in
                        print(error)
                        // Handle error if needed
                        dispatchGroup.leave()
                    })
                    .disposed(by: self.disposeBag)
            }
            dispatchGroup.notify(queue: .global()) {
                single(.success(tempArray))
            }
            return disposable
        }
    }
    
}

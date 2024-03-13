//
//  MoviesServiceManager.swift
//  Cinemax
//
//  Created by IPS-161 on 05/03/24.
//

import Foundation
import Alamofire
import RxSwift

protocol MoviesServiceManagerProtocol {
    func fetchMovieUpcoming(page:Int) -> Single<MasterMovieModel>
    func fetchMovieNowPlaying(page:Int) -> Single<MasterMovieModel>
    func fetchMovieTopRated(page:Int) -> Single<MasterMovieModel>
    func fetchMoviePopular(page:Int) -> Single<MasterMovieModel>
    func fetchMovieDetail(movieId:Int) -> Single<MovieDetailsModel>
    func fetchMovieSimilar(movieId:Int,page: Int) -> Single<MovieResultModel>
    func fetchMovieSearch(searchText:String,page: Int) -> Single<MovieResultModel>
}

final class MoviesServiceManager {
    lazy var movieService = MoviesService()
    static let shared = MoviesServiceManager()
    private init(){}
}

extension MoviesServiceManager : MoviesServiceManagerProtocol  {
    
    func fetchMovieUpcoming(page:Int) -> Single<MasterMovieModel> {
        return Single.create(subscribe:{ (single) -> Disposable in
            let disposables = Disposables.create()
            do{
                try MoviesRouter.movieUpcoming(page: page).request(service: self.movieService)
                    .responseDecodable(of: MasterMovieModel.self, queue: DispatchQueue.global(qos: .utility), completionHandler: { response in
                        switch response.result {
                        case .success(let data):
                            single(.success(data))
                        case .failure(let error):
                            single(.failure(error))
                        }
                    })
            } catch let error{
                single(.failure(error))
            }
            return disposables
        })
    }
    
    func fetchMovieNowPlaying(page:Int) -> Single<MasterMovieModel> {
        return Single.create(subscribe:{ (single) -> Disposable in
            let disposables = Disposables.create()
            do{
                try MoviesRouter.movieNowPlaying(page: page).request(service: self.movieService)
                    .responseDecodable(of: MasterMovieModel.self, queue: DispatchQueue.global(qos: .utility), completionHandler: { response in
                        switch response.result {
                        case .success(let data):
                            single(.success(data))
                        case .failure(let error):
                            single(.failure(error))
                        }
                    })
            } catch let error{
                single(.failure(error))
            }
            return disposables
        })
    }
    
    func fetchMovieTopRated(page:Int) -> Single<MasterMovieModel> {
        return Single.create(subscribe:{ (single) -> Disposable in
            let disposables = Disposables.create()
            do{
                try MoviesRouter.movieTopRated(page: page).request(service: self.movieService)
                    .responseDecodable(of: MasterMovieModel.self, queue: DispatchQueue.global(qos: .utility), completionHandler: { response in
                        switch response.result {
                        case .success(let data):
                            single(.success(data))
                        case .failure(let error):
                            single(.failure(error))
                        }
                    })
            } catch let error{
                single(.failure(error))
            }
            return disposables
        })
    }
    
    func fetchMoviePopular(page:Int) -> Single<MasterMovieModel> {
        return Single.create(subscribe:{ (single) -> Disposable in
            let disposables = Disposables.create()
            do{
                try MoviesRouter.moviePopular(page: page).request(service: self.movieService)
                    .responseDecodable(of: MasterMovieModel.self, queue: DispatchQueue.global(qos: .utility), completionHandler: { response in
                        switch response.result {
                        case .success(let data):
                            single(.success(data))
                        case .failure(let error):
                            single(.failure(error))
                        }
                    })
            } catch let error{
                single(.failure(error))
            }
            return disposables
        })
    }
    
    func fetchMovieDetail(movieId:Int) -> Single<MovieDetailsModel> {
        return Single.create(subscribe:{ (single) -> Disposable in
            let disposables = Disposables.create()
            do{
                try MoviesRouter.movieDetail(movieId: movieId).request(service: self.movieService)
                    .responseDecodable(of: MovieDetailsModel.self, queue: DispatchQueue.global(qos: .utility), completionHandler: { response in
                        switch response.result {
                        case .success(let data):
                            single(.success(data))
                        case .failure(let error):
                            single(.failure(error))
                        }
                    })
            } catch let error{
                single(.failure(error))
            }
            return disposables
        })
    }
    
    func fetchMovieSimilar(movieId:Int,page: Int) -> Single<MovieResultModel> {
        return Single.create(subscribe:{ (single) -> Disposable in
            let disposables = Disposables.create()
            do{
                try MoviesRouter.movieSimilar(similarId: movieId, page:page).request(service: self.movieService)
                    .responseDecodable(of: MovieResultModel.self, queue: DispatchQueue.global(qos: .utility), completionHandler: { response in
                        switch response.result {
                        case .success(let data):
                            single(.success(data))
                        case .failure(let error):
                            single(.failure(error))
                        }
                    })
            } catch let error{
                single(.failure(error))
            }
            return disposables
        })
    }
    
    func fetchMovieSearch(searchText:String,page: Int) -> Single<MovieResultModel> {
        return Single.create(subscribe:{ (single) -> Disposable in
            let disposables = Disposables.create()
            do{
                try MoviesRouter.movieSearch(searchText: searchText, page:page).request(service: self.movieService)
                    .responseDecodable(of: MovieResultModel.self, queue: DispatchQueue.global(qos: .utility), completionHandler: { response in
                        switch response.result {
                        case .success(let data):
                            single(.success(data))
                        case .failure(let error):
                            single(.failure(error))
                        }
                    })
            } catch let error{
                single(.failure(error))
            }
            return disposables
        })
    }
    
}

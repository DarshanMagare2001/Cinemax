//
//  MoviesServiceManager.swift
//  Cinemax
//
//  Created by IPS-161 on 05/02/24.
//

import Foundation

protocol MoviesServiceManagerProtocol {
    func fetchUpcomingMovies(pageCount: Int,completion: @escaping (Result<[MasterMoviesModel]?, Error>) -> ())
    func fetchNowPlayingMovies(pageCount: Int,completion: @escaping (Result<[MasterMoviesModel]?, Error>) -> ())
    func fetchTrendingMovies(pageCount: Int,completion: @escaping (Result<[MasterMoviesModel]?, Error>) -> ())
    func fetchboxOfficeMoviesMovies(pageCount: Int,completion: @escaping (Result<[MasterMoviesModel]?, Error>) -> ())
}


class MoviesServiceManager {
    lazy var moviesService = MoviesService()
    lazy var dispatchGroup = DispatchGroup()
    static let shared = MoviesServiceManager()
    private init(){}
}

extension MoviesServiceManager : MoviesServiceManagerProtocol {
    
    // MARK: - FetchMoviesData
    
    private func fetchMoviesData<T:Decodable>(router: MoviesRouter, model: T.Type, completion: @escaping (Result<T?, ServerError>) -> ()) {
        moviesService.fetchData(router: router, model: model) { result in
            completion(result)
        }
    }
    
    // MARK: - Fetch Upcoming Movies
    
    func fetchUpcomingMovies(pageCount: Int,completion: @escaping (Result<[MasterMoviesModel]?, Error>) -> ()) {
        var tempArray = [MasterMoviesModel]()
        fetchMoviesData(router: MoviesRouter.upComing(pageCount: pageCount), model: MoviesModel.self) { result in
            switch result {
            case .success(let data):
                if let data = data {
                    self.loadMovies(data: data) { result in
                        tempArray.append(contentsOf:result)
                        completion(.success(tempArray))
                    }
                }
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Fetch NowPlaying Movies
    
    func fetchNowPlayingMovies(pageCount: Int,completion: @escaping (Result<[MasterMoviesModel]?, Error>) -> ()) {
        var tempArray = [MasterMoviesModel]()
        fetchMoviesData(router: MoviesRouter.nowPlaying(pageCount: pageCount), model: MoviesModel.self) { result in
            switch result {
            case .success(let data):
                if let data = data {
                    self.loadMovies(data: data) { result in
                        tempArray.append(contentsOf:result)
                        completion(.success(tempArray))
                    }
                }
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Fetch Trending Movies
    
    func fetchTrendingMovies(pageCount: Int,completion: @escaping (Result<[MasterMoviesModel]?, Error>) -> ()) {
        var tempArray = [MasterMoviesModel]()
        fetchMoviesData(router: MoviesRouter.trending(pageCount: pageCount), model: MoviesModel.self) { result in
            switch result {
            case .success(let data):
                if let data = data {
                    self.loadMovies(data: data) { result in
                        tempArray.append(contentsOf:result)
                        completion(.success(tempArray))
                    }
                }
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Fetch boxOfficeMovies Movies
    
    func fetchboxOfficeMoviesMovies(pageCount: Int,completion: @escaping (Result<[MasterMoviesModel]?, Error>) -> ()) {
        var tempArray = [MasterMoviesModel]()
        fetchMoviesData(router: MoviesRouter.boxOfficeMovies(pageCount: pageCount), model: MoviesModel.self) { result in
            switch result {
            case .success(let data):
                if let data = data {
                    self.loadMovies(data: data) { result in
                        tempArray.append(contentsOf:result)
                        completion(.success(tempArray))
                    }
                }
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
    
    
    private func loadMovies(data: MoviesModel, completion: @escaping ([MasterMoviesModel]) -> ()) {
        var tempArray = [MasterMoviesModel]()
        let group = DispatchGroup()  // Create a local group
        
        for movie in data.movieResults {
            group.enter()  // Enter the local group
            self.processData(movie: movie) { result in
                switch result {
                case .success(let data):
                    print(data)
                    tempArray.append(data)
                case .failure(let error):
                    print(error)
                }
                group.leave()  // Leave the local group
            }
        }
        
        group.notify(queue: .main) {
            completion(tempArray)
        }
    }
    
    private func processData(movie: MovieResult, completion: @escaping (Result<MasterMoviesModel, Error>) -> ()) {
        
        var tempMovieDetails: MovieModel?
        var tempMoviesPosterModel: MoviesPosterModel?
        
        dispatchGroup.enter()
        MoviesServiceManager.shared.fetchMoviesData(router: MoviesRouter.movieDetails(movieId: movie.imdbID), model: MovieModel.self) { result in
            switch result {
            case .success(let data):
                print(data)
                tempMovieDetails = data
            case .failure(let error):
                completion(.failure(error))
                print(error)
            }
            self.dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        MoviesServiceManager.shared.fetchMoviesData(router: MoviesRouter.moviesPoster(movieId: movie.imdbID), model: MoviesPosterModel.self) { result in
            switch result {
            case .success(let data):
                print(data)
                tempMoviesPosterModel = data
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
            self.dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue:.global(qos: .background)) {
            if let tempMovieDetails = tempMovieDetails, let tempMoviesPosterModel = tempMoviesPosterModel {
                let masterMoviesModel = MasterMoviesModel(movieModel: tempMovieDetails, moviesPosterModel: tempMoviesPosterModel)
                completion(.success(masterMoviesModel))
            }
        }
    }
    
}

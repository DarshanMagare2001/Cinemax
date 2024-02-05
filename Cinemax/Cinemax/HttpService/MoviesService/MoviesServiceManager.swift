//
//  MoviesServiceManager.swift
//  Cinemax
//
//  Created by IPS-161 on 05/02/24.
//

import Foundation

class MoviesServiceManager {
    lazy var moviesService = MoviesService()
    static let shared = MoviesServiceManager()
    private init(){}
    
    func fetchMoviesData<T:Decodable>(router: MoviesRouter, model: T.Type, completion: @escaping (Result<T?, ServerError>) -> ()) {
        moviesService.fetchData(router: router, model: model) { result in
            completion(result)
        }
    }
    
}

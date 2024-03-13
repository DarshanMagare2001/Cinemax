//
//  MoviesServiceManager.swift
//  Cinemax
//
//  Created by IPS-161 on 05/03/24.
//

import Foundation
import Alamofire
import RxSwift

typealias MoviesClosureResultError = (Result<MoviesModel?, Error>) -> ()

protocol MoviesServiceManagerProtocol {
    func fetchToprated(completionHandler:@escaping MoviesClosureResultError)
    func fetchPopular(completionHandler:@escaping MoviesClosureResultError)
    func fetchUpComing(completionHandler:@escaping MoviesClosureResultError)
    func fetchNowPlaying(completionHandler:@escaping MoviesClosureResultError)
}

final class MoviesServiceManager {
    lazy var movieService = MoviesService()
    static let shared = MoviesServiceManager()
    private init(){}
}

extension MoviesServiceManager : MoviesServiceManagerProtocol  {
    
    func fetchToprated(completionHandler:@escaping MoviesClosureResultError){
        do {
            try MoviesRouter.movieSimilar(similarId: 201485, page:1).request(service: movieService)
                .responseDecodable(of: MovieResultModel.self, queue: DispatchQueue.global(qos: .utility),completionHandler:{ response in
                    switch response.result {
                    case .success(let data):
                        print(data)
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                })
        }catch let error {
            print(error)
            completionHandler(.failure(error))
        }
    }
    
    func fetchPopular(completionHandler:@escaping MoviesClosureResultError){
//        do {
//            try MoviesRouter.popular.request(service: movieService)
//                .responseDecodable(of: MoviesModel.self, queue: DispatchQueue.global(qos: .utility),  completionHandler: { data in
//                    print(data.result)
//                    switch data.result {
//                    case.success(let movies):
//                        completionHandler(.success(movies))
//                    case.failure(let error):
//                        completionHandler(.failure(error))
//                    }
//                })
//        }catch let error {
//            print(error)
//            completionHandler(.failure(error))
//        }
    }
    
    func fetchUpComing(completionHandler:@escaping MoviesClosureResultError){
//        do {
//            try MoviesRouter.upComing.request(service: movieService)
//                .responseDecodable(of: MoviesModel.self, queue: DispatchQueue.global(qos: .utility),  completionHandler: { data in
//                    print(data.result)
//                    switch data.result {
//                    case.success(let movies):
//                        completionHandler(.success(movies))
//                    case.failure(let error):
//                        completionHandler(.failure(error))
//                    }
//                })
//        }catch let error {
//            print(error)
//            completionHandler(.failure(error))
//        }
    }
    
    func fetchNowPlaying(completionHandler:@escaping MoviesClosureResultError){
//        do {
//            try MoviesRouter.nowPlaying.request(service: movieService)
//                .responseDecodable(of: MoviesModel.self, queue: DispatchQueue.global(qos: .utility),  completionHandler: { data in
//                    print(data.result)
//                    switch data.result {
//                    case.success(let movies):
//                        completionHandler(.success(movies))
//                    case.failure(let error):
//                        completionHandler(.failure(error))
//                    }
//                })
//        }catch let error {
//            print(error)
//            completionHandler(.failure(error))
//        }
    }
    
}

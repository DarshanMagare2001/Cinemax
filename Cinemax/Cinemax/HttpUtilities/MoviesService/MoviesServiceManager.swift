//
//  MoviesServiceManager.swift
//  Cinemax
//
//  Created by IPS-161 on 05/03/24.
//

import Foundation
import Alamofire

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
            try MoviesRouter.movieUpcoming.request(service: movieService)
                .response(completionHandler: { response in
                    switch response.result {
                    case .success(let data):
                        if let responseData = data {
                            print(String(data: responseData, encoding: .utf8))
                        } else {
                            print("Response data is nil")
                        }
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                })
//                .responseDecodable(of: MoviesModel.self, queue: DispatchQueue.global(qos: .utility),  completionHandler: { data in
//                    print(data.result)
//                    switch data.result {
//                    case.success(let movies):
//                        completionHandler(.success(movies))
//                    case.failure(let error):
//                        completionHandler(.failure(error))
//                    }
//                })
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

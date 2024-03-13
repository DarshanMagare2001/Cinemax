//
//  MoviesRouter.swift
//  Cinemax
//
//  Created by IPS-161 on 05/03/24.
//

import Foundation
import Alamofire

//"https://api.themoviedb.org/3/movie/top_rated?api_key=9f7ceb7615afe6f16274a953ad31c29e&language=en-US&page=1"

//enum MoviesRouter: HttpRouterProtocol {
//    case topRated
//    case popular
//    case upComing
//    case nowPlaying
//
//    var baseUrlString: String {
//        return "https://api.themoviedb.org/3/movie/"
//    }
//
//    var path: String {
//        switch self {
//        case .topRated:
//            return "top_rated?api_key=9f7ceb7615afe6f16274a953ad31c29e"
//        case .popular:
//            return "popular?api_key=9f7ceb7615afe6f16274a953ad31c29e"
//        case .upComing:
//            return "upcoming?api_key=9f7ceb7615afe6f16274a953ad31c29e"
//        case .nowPlaying:
//            return "now_playing?api_key=9f7ceb7615afe6f16274a953ad31c29e"
//        }
//    }
//
//    var method: HTTPMethod {
//        return .get
//    }
//
//    var headers: HTTPHeaders? {
//        return nil
//    }
//
//    var parameters: Parameters? {
//        return nil
//    }
//
//    //    var parameters: Parameters? {
//    //        switch self {
//    //        case .topRated, .popular, .upComing, .nowPlaying:
//    //            return [
//    //                "api_key": "9f7ceb7615afe6f16274a953ad31c29e"
//    //            ]
//    //        }
//    //    }
//
//    func body() throws -> Data? {
//        return nil
//    }
//}


enum MoviesRouter: HttpRouterProtocol {
    
    case movieUpcoming
    case moviePlaying
    case movieDetail(movieId:Int)
    case movieSimilar(similarId:Int)
    case movieSearch(searchText: String)
    
    var baseUrlString : String {
        return "https://api.themoviedb.org/3"
    }
    
    var method: HTTPMethod {
        switch self {
        case  .movieUpcoming, .moviePlaying, .movieDetail,.movieSimilar, .movieSearch:
            return .get
        }
    }
    
    var parameters: [String:Any]? {
        var params: Parameters = [:]
        switch self {
        case .movieSimilar:
            return ["api_key":"c928e02d6dfb0146a55c6dfcd8d06085"]
        case .movieUpcoming:
            return ["api_key":"c928e02d6dfb0146a55c6dfcd8d06085"]
        case .moviePlaying:
            return ["api_key":"c928e02d6dfb0146a55c6dfcd8d06085"]
        case .movieDetail:
            return ["api_key":"c928e02d6dfb0146a55c6dfcd8d06085"]
        case .movieSimilar:
            return ["api_key":"c928e02d6dfb0146a55c6dfcd8d06085"]
        case .movieSearch(let text):
            return ["api_key":"c928e02d6dfb0146a55c6dfcd8d06085",
                    "query": text]
        }
        return params
    }
    
    var path:String {
        switch self {
        case .movieUpcoming:
            return "/movie/upcoming"
        case .moviePlaying:
            return "/movie/now_playing"
        case .movieDetail(movieId: let movieID):
            return "/movie/\(movieID)"
        case .movieSimilar(similarId: let similarId):
            return "/movie/\(similarId)/similar"
        case .movieSearch:
            return "/search/movie"
        }
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var headers: HTTPHeaders? {
        return ["Accept":"application/json","Content-Type":"application/json"]
    }
    
    func body() throws -> Data? {
        return nil
    }
    
}

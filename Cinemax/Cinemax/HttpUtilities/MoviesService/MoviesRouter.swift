//
//  MoviesRouter.swift
//  Cinemax
//
//  Created by IPS-161 on 05/03/24.
//

import Foundation
import Alamofire

//"https://api.themoviedb.org/3/movie/top_rated?api_key=38a73d59546aa378980a88b645f487fc&language=en-US&page=1"

enum MoviesRouter: HttpRouterProtocol {
    
    case movieUpcoming(page:Int)
    case movieNowPlaying(page:Int)
    case movieTopRated(page:Int)
    case moviePopular(page:Int)
    case movieDetail(movieId:Int)
    case movieSimilar(similarId:Int,page:Int)
    case movieSearch(searchText: String,page:Int)
    
    var baseUrlString: String {
        return "https://api.themoviedb.org/3"
    }
    
    var path: String {
        switch self {
        case .movieUpcoming(let page):
            return "/movie/upcoming?api_key=38a73d59546aa378980a88b645f487fc&language=en-US&page=\(page)"
        case .movieNowPlaying(let page):
            return "/movie/now_playing?api_key=38a73d59546aa378980a88b645f487fc&language=en-US&page=\(page)"
        case .movieTopRated(let page):
            return "/movie/top_rated?api_key=38a73d59546aa378980a88b645f487fc&language=en-US&page=\(page)"
        case .moviePopular(let page):
            return "/movie/popular?api_key=38a73d59546aa378980a88b645f487fc&language=en-US&page=\(page)"
        case .movieDetail(let movieId):
            return "/movie/\(movieId)?api_key=38a73d59546aa378980a88b645f487fc&language=en-US"
        case .movieSimilar(let similarId , let page):
            return "/movie/\(similarId)/similar?api_key=38a73d59546aa378980a88b645f487fc&language=en-US&page=\(page)"
        case .movieSearch(let searchText , let page):
            return "/search/movie?api_key=38a73d59546aa378980a88b645f487fc&language=en-US&page=\(page)&query=\(searchText)"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var parameters: Parameters? {
        return nil
    }
    
    func body() throws -> Data? {
        return nil
    }
    
}

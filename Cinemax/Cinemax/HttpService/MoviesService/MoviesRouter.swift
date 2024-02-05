//
//  MoviesRouter.swift
//  Cinemax
//
//  Created by IPS-161 on 05/02/24.
//

import Foundation

enum MoviesRouter {
    case upComing(pageCount: Int)
    case nowPlaying(pageCount: Int)
    case popular(pageCount: Int)
    case topRated(pageCount: Int)
    
    var pageCount: Int {
        switch self {
        case .upComing(let count), .nowPlaying(let count), .popular(let count), .topRated(let count):
            return count
        }
    }
}

extension MoviesRouter {
    
    var baseUrl: String {
        return "https://api.themoviedb.org/3/movie/"
    }
    
    var path: String {
        switch self {
        case .upComing:
            return "upcoming?api_key=38a73d59546aa378980a88b645f487fc"
        case .nowPlaying:
            return "now_playing?api_key=38a73d59546aa378980a88b645f487fc"
        case .popular:
            return "popular?api_key=38a73d59546aa378980a88b645f487fc"
        case .topRated:
            return "top_rated?api_key=38a73d59546aa378980a88b645f487fc"
        }
    }
    
    var headers: [String: String] {
        return ["accept": "application/json"]
    }
    
    var request: URLRequest {
        let url = URL(string: "\(baseUrl)\(path)&language=en-US&page=\(pageCount)")!
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        return request
    }
}

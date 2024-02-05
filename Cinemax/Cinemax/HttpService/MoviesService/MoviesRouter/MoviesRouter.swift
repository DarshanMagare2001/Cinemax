//
//  MoviesRouter.swift
//  Cinemax
//
//  Created by IPS-161 on 05/02/24.
//

import Foundation

enum MoviesRouter {
    case upComing
    case nowPlaying
    case popular
    case topRated
}

extension MoviesRouter {
    
    var baseUrl: String {
        return "https://api.themoviedb.org/3/movie/"
    }
    
    var path:String {
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
    
    var url: URL {
        return URL(string: "\(baseUrl)\(path)")!
    }
    
}

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
    case trending(pageCount: Int)
    case boxOfficeMovies(pageCount: Int)
    
    var pageCount: Int {
        switch self {
        case .upComing(let count), .nowPlaying(let count), .trending(let count), .boxOfficeMovies(let count):
            return count
        }
    }
}

extension MoviesRouter {
    
    var path: String {
        switch self {
        case .upComing:
            return "https://movies-tv-shows-database.p.rapidapi.com/?page="
        case .nowPlaying:
            return "https://movies-tv-shows-database.p.rapidapi.com/?page="
        case .trending:
            return "https://movies-tv-shows-database.p.rapidapi.com/?page="
        case .boxOfficeMovies:
            return "https://movies-tv-shows-database.p.rapidapi.com/?page="
        }
    }
    
    var headers: [String: String] {
        switch self {
        case .upComing:
            return [
                "Type": "get-upcoming-movies",
                "X-RapidAPI-Key": "021108c3cdmshf759245e646191bp1ef32ejsn38795d85e69c",
                "X-RapidAPI-Host": "movies-tv-shows-database.p.rapidapi.com"
            ]
        case .nowPlaying:
            return [
                "Type": "get-nowplaying-movies",
                "X-RapidAPI-Key": "021108c3cdmshf759245e646191bp1ef32ejsn38795d85e69c",
                "X-RapidAPI-Host": "movies-tv-shows-database.p.rapidapi.com"
            ]
        case .trending:
            return [
                "Type": "get-trending-movies",
                "X-RapidAPI-Key": "021108c3cdmshf759245e646191bp1ef32ejsn38795d85e69c",
                "X-RapidAPI-Host": "movies-tv-shows-database.p.rapidapi.com"
            ]
        case .boxOfficeMovies:
            return [
                "Type": "get-boxoffice-movies",
                "X-RapidAPI-Key": "021108c3cdmshf759245e646191bp1ef32ejsn38795d85e69c",
                "X-RapidAPI-Host": "movies-tv-shows-database.p.rapidapi.com"
            ]
        }
        
    }
    
    var request: URLRequest {
        let url = URL(string: "\(path)\(pageCount)")!
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        return request
    }
}

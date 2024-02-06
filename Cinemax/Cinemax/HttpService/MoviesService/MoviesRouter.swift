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
    case movieDetails(movieId: String)
    case moviesPoster(movieId: String)
    
    var pageCount: Int {
        switch self {
        case .upComing(let count), .nowPlaying(let count), .trending(let count), .boxOfficeMovies(let count):
            return count
        case .moviesPoster(let movieId):
            return 0
        case .movieDetails(let movieId):
            return 0
        }
    }
    
    var movieId: String {
        switch self {
        case .moviesPoster(let movieId):
            return movieId
        case .movieDetails(let movieId):
            return movieId
        case .upComing(let pageCount):
            return ""
        case .nowPlaying(let pageCount):
            return ""
        case .trending( let pageCount):
            return ""
        case .boxOfficeMovies(let pageCount):
            return ""
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
        case .moviesPoster:
            return "https://movies-tv-shows-database.p.rapidapi.com/?movieid="
        case .movieDetails:
            return "https://movies-tv-shows-database.p.rapidapi.com/?movieid="
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
        case .moviesPoster:
            return [
                "Type": "get-movies-images-by-imdb",  // Corrected header for moviesPoster
                "X-RapidAPI-Key": "021108c3cdmshf759245e646191bp1ef32ejsn38795d85e69c",
                "X-RapidAPI-Host": "movies-tv-shows-database.p.rapidapi.com"
            ]
        case .movieDetails:
            return [
                "Type": "get-movie-details",
                "X-RapidAPI-Key": "021108c3cdmshf759245e646191bp1ef32ejsn38795d85e69c",
                "X-RapidAPI-Host": "movies-tv-shows-database.p.rapidapi.com"
            ]
        }
    }
    
    var request: URLRequest {
        switch self {
        case .upComing:
            return generateRequestForMovies()
        case .nowPlaying:
            return generateRequestForMovies()
        case .trending:
            return generateRequestForMovies()
        case .boxOfficeMovies:
            return generateRequestForMovies()
        case .moviesPoster:
            return generateRequestForMoviesPoster()
        case .movieDetails:
            return generateRequestForMoviesPoster()
        }
    }
    
    private func generateRequestForMovies() -> URLRequest {
        let url = URL(string: "\(path)\(pageCount)")!
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        return request
    }
    
    private func generateRequestForMoviesPoster() -> URLRequest {
        let url = URL(string: "\(path)\(movieId)")!
        print(url)
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        print(headers)
        return request
    }
    
}

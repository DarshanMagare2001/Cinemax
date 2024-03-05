//
//  MovieModel.swift
//  Cinemax
//
//  Created by IPS-161 on 06/02/24.
//

import Foundation

// MARK: - MovieModel

struct MovieModel: Codable {
    let title, description, tagline: String?
    let year, releaseDate, imdbID, imdbRating: String?
    let voteCount, popularity, youtubeTrailerKey: String?
    let rated: String?
    let runtime: Int?
    let genres, stars, directors, countries: [String]?
    let language: [String]?  // Change this line to make language an array of strings
    let status, statusMessage: String?

    enum CodingKeys: String, CodingKey {
        case title, description, tagline, year
        case releaseDate = "release_date"
        case imdbID = "imdb_id"
        case imdbRating = "imdb_rating"
        case voteCount = "vote_count"
        case popularity
        case youtubeTrailerKey = "youtube_trailer_key"
        case rated, runtime, genres, stars, directors, countries, language, status
        case statusMessage = "status_message"
    }
}

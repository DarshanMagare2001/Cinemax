//
//  MoviesPosterModel.swift
//  Cinemax
//
//  Created by IPS-161 on 06/02/24.
//

import Foundation

// MARK: - MoviesPosterModel
struct MoviesPosterModel: Codable {
    let title, imdb: String
    let poster: String
    let fanart, status, statusMessage: String

    enum CodingKeys: String, CodingKey {
        case title
        case imdb = "IMDB"
        case poster, fanart, status
        case statusMessage = "status_message"
    }
}


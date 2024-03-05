//
//  MasterMoviesModel.swift
//  Cinemax
//
//  Created by IPS-161 on 06/02/24.
//

import Foundation

struct MasterMoviesModel {
    var movieModel: MovieModel
    var moviesPosterModel: MoviesPosterModel
    init(movieModel: MovieModel,moviesPosterModel: MoviesPosterModel){
        self.movieModel = movieModel
        self.moviesPosterModel = moviesPosterModel
    }
}

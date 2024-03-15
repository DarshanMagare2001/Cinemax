//
//  DetailVCInteractor.swift
//  Cinemax
//
//  Created by IPS-161 on 15/03/24.
//

import Foundation
import RxSwift

protocol DetailVCInteractorProtocol {
    func fetchMovieDetail(movieId:Int) -> Single<MovieDetailsModel>
}

class DetailVCInteractor {
    var moviesServiceManager : MoviesServiceManagerProtocol
    init(moviesServiceManager : MoviesServiceManagerProtocol){
        self.moviesServiceManager = moviesServiceManager
    }
}

extension DetailVCInteractor : DetailVCInteractorProtocol {
    func fetchMovieDetail(movieId:Int) -> Single<MovieDetailsModel> {
        return moviesServiceManager.fetchMovieDetail(movieId:movieId)
    }
}

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
    func fetchMovieSimilar(movieId:Int,page: Int) -> Single<MovieResultModel>
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
    func fetchMovieSimilar(movieId:Int,page: Int) -> Single<MovieResultModel>{
        return moviesServiceManager.fetchMovieSimilar(movieId: movieId, page: page)
    }
}

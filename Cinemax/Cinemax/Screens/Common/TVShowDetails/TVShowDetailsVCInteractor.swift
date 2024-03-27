//
//  TVShowDetailsVCInteractor.swift
//  Cinemax
//
//  Created by IPS-161 on 27/03/24.
//

import Foundation
import RxSwift

protocol TVShowDetailsVCInteractorProtocol {
    func fetchTVShowDetails(showId:Int) -> Single<TVShowDetailsResponseModel>
}

class TVShowDetailsVCInteractor {
    var moviesServiceManager : MoviesServiceManagerProtocol
    init(moviesServiceManager : MoviesServiceManagerProtocol){
        self.moviesServiceManager = moviesServiceManager
    }
}

extension TVShowDetailsVCInteractor: TVShowDetailsVCInteractorProtocol {
    func fetchTVShowDetails(showId:Int) -> Single<TVShowDetailsResponseModel>{
        return moviesServiceManager.fetchTVShowDetails(showId: showId)
    }
}

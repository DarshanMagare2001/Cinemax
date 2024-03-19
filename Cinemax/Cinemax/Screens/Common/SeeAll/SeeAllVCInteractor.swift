//
//  SeeAllVCInteractor.swift
//  Cinemax
//
//  Created by IPS-161 on 19/03/24.
//

import Foundation

protocol SeeAllVCInteractorProtocol {
    
}

class SeeAllVCInteractor {
    var movieServiceManager: MoviesServiceManagerProtocol
    init(movieServiceManager: MoviesServiceManagerProtocol){
        self.movieServiceManager = movieServiceManager
    }
}

extension SeeAllVCInteractor: SeeAllVCInteractorProtocol  {
    
}

//
//  GenresVCPresenter.swift
//  Cinemax
//
//  Created by IPS-161 on 03/04/24.
//

import Foundation

protocol GenresVCPresenterProtocol {
    func viewDidload()
}

class GenresVCPresenter {
    weak var view: GenresVCProtocol?
    var interactor: GenresVCInteractorProtocol
    var router: GenresVCRouterProtocol
    init(view: GenresVCProtocol,interactor: GenresVCInteractorProtocol,router: GenresVCRouterProtocol){
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension GenresVCPresenter: GenresVCPresenterProtocol {
    func viewDidload(){
        
    }
}

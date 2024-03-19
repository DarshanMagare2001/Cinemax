//
//  SeeAllVCPresenter.swift
//  Cinemax
//
//  Created by IPS-161 on 19/03/24.
//

import Foundation

protocol SeeAllVCPresenterProtocol {
    func viewDidload()
}

class SeeAllVCPresenter {
    weak var view: SeeAllVCProtocol?
    var interactor: SeeAllVCInteractorProtocol
    var router: SeeAllVCRouterProtocol
    init(view: SeeAllVCProtocol,interactor: SeeAllVCInteractorProtocol,router: SeeAllVCRouterProtocol){
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension SeeAllVCPresenter: SeeAllVCPresenterProtocol  {
    func viewDidload(){
        
    }
}


//
//  WishListVCPresenter.swift
//  Cinemax
//
//  Created by IPS-161 on 04/04/24.
//

import Foundation

protocol WishListVCPresenterProtocol {
    func viewDidload()
}

class WishListVCPresenter {
    weak var view: WishListVCProtocol?
    var interactor: WishListVCInteractorProtocol
    var router: WishListVCRouterProtocol
    init(view: WishListVCProtocol?,interactor: WishListVCInteractorProtocol,router: WishListVCRouterProtocol){
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension WishListVCPresenter: WishListVCPresenterProtocol {
    func viewDidload(){
        
    }
}

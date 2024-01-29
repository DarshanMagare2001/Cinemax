//
//  ResetPasswordVCPresenter.swift
//  Cinemax
//
//  Created by IPS-161 on 29/01/24.
//

import Foundation

protocol ResetPasswordVCPresenterProtocol {
    func viewDidload()
    func goToCreatenewpasswordVC()
}

class ResetPasswordVCPresenter {
    weak var view: ResetPasswordVCPrtocol?
    var interactor: ResetPasswordVCInteractorProtocol
    var router: ResetPasswordVCRouterProtocol
    init(view: ResetPasswordVCPrtocol,interactor: ResetPasswordVCInteractorProtocol,router: ResetPasswordVCRouterProtocol){
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension ResetPasswordVCPresenter: ResetPasswordVCPresenterProtocol {
    func viewDidload(){
   
    }
    func goToCreatenewpasswordVC(){
        router.goToCreatenewpasswordVC()
    }
}

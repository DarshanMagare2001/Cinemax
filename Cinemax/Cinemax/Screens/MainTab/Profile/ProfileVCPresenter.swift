//
//  ProfileVCPresenter.swift
//  Cinemax
//
//  Created by IPS-161 on 01/02/24.
//

import Foundation

protocol ProfileVCPresenterProtocol {
    func viewDidload()
    func currentUserLogout()
}

class ProfileVCPresenter {
    weak var view: ProfileVCProtocol?
    var interactor: ProfileVCInteractorProtocol
    var router: ProfileVCRouterProtocol
    init(view: ProfileVCProtocol,interactor: ProfileVCInteractorProtocol,router: ProfileVCRouterProtocol){
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension ProfileVCPresenter: ProfileVCPresenterProtocol {
    func viewDidload(){
        
    }
    func currentUserLogout(){
        interactor.currentUserLogout { result in
            switch result {
            case.success(let bool):
                print(bool)
            case.failure(let error):
                print(error)
            }
        }
    }
}

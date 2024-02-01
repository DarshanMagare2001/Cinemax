//
//  ProfileVCPresenter.swift
//  Cinemax
//
//  Created by IPS-161 on 01/02/24.
//

import Foundation

protocol ProfileVCPresenterProtocol {
    func viewDidload()
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
}

//
//  SignUpCredentialVCPresenter.swift
//  Cinemax
//
//  Created by IPS-161 on 29/01/24.
//

import Foundation

protocol SignUpCredentialVCPresenterProtocol {
    func viewDidload()
}

class SignUpCredentialVCPresenter {
    weak var view: SignUpCredentialVCProtocol?
    var interactor: SignUpCredentialVCInteractorProtocol
    var router: SignUpCredentialVCRouterProtocol
    init(view: SignUpCredentialVCProtocol,interactor: SignUpCredentialVCInteractorProtocol,router: SignUpCredentialVCRouterProtocol){
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension SignUpCredentialVCPresenter: SignUpCredentialVCPresenterProtocol {
    func viewDidload(){
        
    }
}

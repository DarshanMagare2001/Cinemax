//
//  SignUpVCPresenter.swift
//  Cinemax
//
//  Created by IPS-161 on 29/01/24.
//

import Foundation

protocol SignUpVCPresenterProtocol {
    func viewDidload()
    func goToSignUpCredentialVC()
}

class SignUpVCPresenter {
    weak var view: SignUpVCProtocol?
    var interactor: SignUpVCInteractorProtocol
    var router: SignUpVCRouterProtocol
    init(view: SignUpVCProtocol,interactor: SignUpVCInteractorProtocol,router: SignUpVCRouterProtocol){
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension SignUpVCPresenter: SignUpVCPresenterProtocol {
    func viewDidload(){
        
    }
    
    func goToSignUpCredentialVC(){
        router.goToSignUpCredentialVC()
    }
}

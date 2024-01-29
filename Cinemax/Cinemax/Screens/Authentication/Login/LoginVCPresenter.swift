//
//  LoginVCPresenter.swift
//  Cinemax
//
//  Created by IPS-161 on 29/01/24.
//

import Foundation
import UIKit

protocol LoginVCPresenterProtocol {
    func viewDidload()
    func goToResetPasswordVC()
}

class LoginVCPresenter {
    weak var view: LoginVCProtocol?
    var interactor: LoginVCInteractorProtocol
    var router: LoginVCRouterProtocol
    init(view: LoginVCProtocol,interactor: LoginVCInteractorProtocol,router: LoginVCRouterProtocol){
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension LoginVCPresenter: LoginVCPresenterProtocol {
    func viewDidload(){
        print("viewDidload")
    }
    func goToResetPasswordVC(){
        router.goToResetPasswordVC()
    }
}


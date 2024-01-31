//
//  SignUpVCPresenter.swift
//  Cinemax
//
//  Created by IPS-161 on 29/01/24.
//

import Foundation
import UIKit

protocol SignUpVCPresenterProtocol {
    func viewDidload()
    func goToSignUpCredentialVC()
    func goToLoginVC()
    func signinWithGoogle(view: UIViewController)
    func goToMainTabVC()
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
    
    func goToLoginVC(){
        router.goToLoginVC()
    }
    
    func signinWithGoogle(view: UIViewController){
        interactor.signinWithGoogle(view: view) { result in
            switch result {
            case.success(let bool):
                print(bool)
                DispatchQueue.main.async { [weak self] in
                    self?.goToMainTabVC()
                }
            case.failure(let error):
                print(error)
                DispatchQueue.main.async { [weak self] in
                    self?.view?.errorAlert(message: error.localizedDescription)
                }
            }
        }
    }
    
    func goToMainTabVC(){
        router.goToMainTabVC()
    }
    
}

//
//  LoginVCPresenter.swift
//  Cinemax
//
//  Created by IPS-161 on 29/01/24.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

protocol LoginVCPresenterProtocol {
    
    func viewDidload()
    func goToResetPasswordVC()
    func signIn(email: String?, password: String?)
    
    typealias Input = (
        email : Driver<String>,
        password : Driver<String>,
        login:Driver<Void>
    )
    
    typealias Output = (
        enableLogin : Driver<Bool>,
        emailWarning: Driver<Bool>,
        passwordWarning: Driver<Bool>
    )
    
    typealias Producer = (LoginVCPresenterProtocol.Input) -> LoginVCPresenterProtocol
    
    var input : Input { get }
    var output : Output { get }
    
}

class LoginVCPresenter {
    weak var view: LoginVCProtocol?
    var interactor: LoginVCInteractorProtocol
    var router: LoginVCRouterProtocol
    var input:Input
    var output:Output
    init(view: LoginVCProtocol,interactor: LoginVCInteractorProtocol,router: LoginVCRouterProtocol,input:Input){
        self.view = view
        self.interactor = interactor
        self.router = router
        self.input = input
        self.output = LoginVCPresenter.output(input: input)
    }
}

extension LoginVCPresenter: LoginVCPresenterProtocol {
    func viewDidload(){
        DispatchQueue.main.async { [weak self] in
            self?.view?.setUpBinding()
            self?.view?.updateUI()
        }
    }
    
    func signIn(email: String?, password: String?){
        showLoader()
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.interactor.signIn(email: email, password: password) { result in
                switch result {
                case.success(let bool):
                    print(bool)
                    //                    self?.saveUsersDataToUserdefault(name: name, email: email, password: password)
                    self?.hideLoader()
                case.failure(let error):
                    switch error {
                    case .invalidCredentials:
                        print("Invalid credentials")
                        self?.hideLoader()
                        DispatchQueue.main.asyncAfter(deadline: .now()+1) { [weak self] in
                            self?.view?.errorAlert(message: "Invalid credentials")
                        }
                    case .serverError(let serverError):
                        self?.hideLoader()
                        DispatchQueue.main.asyncAfter(deadline: .now()+1) { [weak self] in
                            self?.view?.errorAlert(message: serverError.localizedDescription)
                        }
                    }
                }
            }
        }
    }
    
    private func showLoader(){
        Loader.shared.showLoader(type: .lineScale, color: .white)
    }
    
    private func hideLoader(){
        Loader.shared.hideLoader()
    }
    
    
    func goToResetPasswordVC(){
        router.goToResetPasswordVC()
    }
}

private extension LoginVCPresenter {
    
    static func output(input:Input) -> Output {
        let enableLoginDriver =  Driver.combineLatest(input.email.map{( $0.isEmailValid())},
                                                      input.password.map{( !$0.isEmpty && $0.isPasswordValid())})
            .map{( $0 && $1 )}
        
        let emailWarningDriver = input.email.map { $0.isEmailValid() }
        let passwordWarningDriver = input.password.map { !$0.isEmpty && $0.isPasswordValid() }
        
        return (
            enableLogin : enableLoginDriver,
            emailWarning: emailWarningDriver,
            passwordWarning: passwordWarningDriver
        )
    }
    
}

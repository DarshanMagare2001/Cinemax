//
//  ResetPasswordVCPresenter.swift
//  Cinemax
//
//  Created by IPS-161 on 29/01/24.
//

import Foundation
import RxCocoa
import RxSwift

protocol ResetPasswordVCPresenterProtocol {
    func viewDidload()
    func goToCreatenewpasswordVC()
    
    typealias Input = (
        email : Driver<String>,
        login:Driver<Void>
    )
    
    typealias Output = (
        enableLogin : Driver<Bool>,
        emailWarning: Driver<Bool>
    )
    
    typealias Producer = (ResetPasswordVCPresenterProtocol.Input) -> ResetPasswordVCPresenterProtocol
    
    var input : Input { get }
    var output : Output { get }
    
}

class ResetPasswordVCPresenter {
    weak var view: ResetPasswordVCPrtocol?
    var interactor: ResetPasswordVCInteractorProtocol
    var router: ResetPasswordVCRouterProtocol
    var input:Input
    var output:Output
    init(view: ResetPasswordVCPrtocol,interactor: ResetPasswordVCInteractorProtocol,router: ResetPasswordVCRouterProtocol ,input:Input){
        self.view = view
        self.interactor = interactor
        self.router = router
        self.input = input
        self.output = ResetPasswordVCPresenter.output(input: input)
    }
}

extension ResetPasswordVCPresenter: ResetPasswordVCPresenterProtocol {
    func viewDidload(){
        DispatchQueue.main.async { [weak self] in
            self?.view?.setUpBinding()
            self?.view?.updateUI()
        }
    }
    func goToCreatenewpasswordVC(){
        router.goToCreatenewpasswordVC()
    }
}

private extension ResetPasswordVCPresenter {
    
    static func output(input:Input) -> Output {
        let enableLoginDriver =  input.email.map { $0.isEmailValid() }
        let emailWarningDriver = input.email.map { $0.isEmailValid() }
        return (
            enableLogin : enableLoginDriver,
            emailWarning: emailWarningDriver
        )
    }
    
}

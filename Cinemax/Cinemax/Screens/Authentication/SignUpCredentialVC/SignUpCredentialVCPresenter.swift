//
//  SignUpCredentialVCPresenter.swift
//  Cinemax
//
//  Created by IPS-161 on 29/01/24.
//

import Foundation
import RxCocoa
import RxSwift

protocol SignUpCredentialVCPresenterProtocol {
    func viewDidload()
    typealias Input = (
        email : Driver<String>,
        password : Driver<String>,
        fullName : Driver<String>,
        isTermsAndConditionAccept : Driver<Bool>,
        login:Driver<Void>
    )
    
    typealias Output = (
        enableLogin : Driver<Bool>,()
    )
    
    typealias Producer = (SignUpCredentialVCPresenterProtocol.Input) -> SignUpCredentialVCPresenterProtocol
    
    var input : Input { get }
    var output : Output { get }
}

class SignUpCredentialVCPresenter {
    weak var view: SignUpCredentialVCProtocol?
    var interactor: SignUpCredentialVCInteractorProtocol
    var router: SignUpCredentialVCRouterProtocol
    var input:Input
    var output:Output
    init(view: SignUpCredentialVCProtocol,interactor: SignUpCredentialVCInteractorProtocol,router: SignUpCredentialVCRouterProtocol,input:Input){
        self.view = view
        self.interactor = interactor
        self.router = router
        self.input = input
        self.output = SignUpCredentialVCPresenter.output(input: input)
    }
}

extension SignUpCredentialVCPresenter: SignUpCredentialVCPresenterProtocol {
    
    func viewDidload(){
        view?.setupWarningLbls()
        DispatchQueue.main.async { [weak self] in
            self?.view?.setUpBinding()
        }
    }
    
}

private extension SignUpCredentialVCPresenter {
    
    static func output(input:Input) -> Output {
        let enableLoginDriver =  Driver.combineLatest(input.email.map{( $0.isEmailValid())},
                                                      input.password.map{( !$0.isEmpty && $0.isPasswordValid())},
                                                      input.fullName.map{(!$0.isEmpty)},
                                                      input.isTermsAndConditionAccept.map{(
                                                        ($0 == true) ? true : false )}
        ).map{( $0 && $1 && $2 && $3 )}
        return (
            enableLogin:enableLoginDriver,()
        )
    }
    
}

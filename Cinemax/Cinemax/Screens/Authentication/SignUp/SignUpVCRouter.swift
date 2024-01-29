//
//  SignUpVCRouter.swift
//  Cinemax
//
//  Created by IPS-161 on 29/01/24.
//

import Foundation
import UIKit

protocol SignUpVCRouterProtocol {
    func goToSignUpCredentialVC()
    func goToLoginVC()
}

class SignUpVCRouter {
    var viewController: UIViewController
    init(viewController: UIViewController){
        self.viewController = viewController
    }
}

extension SignUpVCRouter: SignUpVCRouterProtocol {
    func goToSignUpCredentialVC(){
        let signUpCredentialVC = SignUpCredentialVCBuilder.build()
        viewController.navigationController?.pushViewController(signUpCredentialVC, animated: true)
    }
    
    func goToLoginVC(){
        let loginVC = LoginVCBuilder.build()
        viewController.navigationController?.pushViewController(loginVC, animated: true)
    }
    
}


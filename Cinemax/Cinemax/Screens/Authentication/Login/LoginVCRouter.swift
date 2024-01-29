//
//  LoginVCRouter.swift
//  Cinemax
//
//  Created by IPS-161 on 29/01/24.
//

import Foundation
import UIKit

protocol LoginVCRouterProtocol {
    func goToResetPasswordVC()
}

class LoginVCRouter {
    var viewController: UIViewController
    init(viewController: UIViewController){
        self.viewController = viewController
    }
}

extension LoginVCRouter: LoginVCRouterProtocol {
    func goToResetPasswordVC(){
        let resetPasswordVC = ResetPasswordVCBuilder.build()
        viewController.navigationController?.pushViewController(resetPasswordVC, animated: true)
    }
}


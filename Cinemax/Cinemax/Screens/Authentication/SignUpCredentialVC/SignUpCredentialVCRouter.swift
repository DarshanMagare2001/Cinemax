//
//  SignUpCredentialVCRouter.swift
//  Cinemax
//
//  Created by IPS-161 on 29/01/24.
//

import Foundation
import UIKit

protocol SignUpCredentialVCRouterProtocol {
    
}

class SignUpCredentialVCRouter {
    var viewController: UIViewController
    init(viewController: UIViewController){
        self.viewController = viewController
    }
}

extension SignUpCredentialVCRouter: SignUpCredentialVCRouterProtocol {
    
}


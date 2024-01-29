//
//  ResetPasswordVCRouter.swift
//  Cinemax
//
//  Created by IPS-161 on 29/01/24.
//

import Foundation
import UIKit

protocol ResetPasswordVCRouterProtocol {
    func goToCreatenewpasswordVC()
}

class ResetPasswordVCRouter {
    var viewController: UIViewController
    init(viewController: UIViewController){
        self.viewController = viewController
    }
}

extension ResetPasswordVCRouter: ResetPasswordVCRouterProtocol {
    func goToCreatenewpasswordVC(){
        let createnewpasswordVC = CreatenewpasswordVCBuilder.build()
        viewController.navigationController?.pushViewController(createnewpasswordVC, animated: true)
    }
}


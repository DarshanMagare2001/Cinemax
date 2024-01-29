//
//  LoginVCBuilder.swift
//  Cinemax
//
//  Created by IPS-161 on 25/01/24.
//

import Foundation
import UIKit

public final class LoginVCBuilder {
    static func build() -> UIViewController {
        let storyboard = UIStoryboard.Authentication
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        let interactor = LoginVCInteractor()
        let router = LoginVCRouter(viewController: loginVC)
        let presenter = LoginVCPresenter(view: loginVC, interactor: interactor, router: router)
        loginVC.presenter = presenter
        return loginVC
    }
}

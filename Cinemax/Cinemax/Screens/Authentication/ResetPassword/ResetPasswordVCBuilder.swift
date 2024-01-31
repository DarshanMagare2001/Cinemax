//
//  ResetPasswordVCBuilder.swift
//  Cinemax
//
//  Created by IPS-161 on 29/01/24.
//

import Foundation
import UIKit

public final class ResetPasswordVCBuilder {
    
    static var backButtonPressedClosure : (()->())?
    
    static func build() -> UIViewController {
        let storyboard = UIStoryboard.Authentication
        let resetPasswordVC = storyboard.instantiateViewController(withIdentifier: "ResetPasswordVC") as! ResetPasswordVC
        let interactor = ResetPasswordVCInteractor()
        let router = ResetPasswordVCRouter(viewController: resetPasswordVC)
        let presenter = ResetPasswordVCPresenter(view: resetPasswordVC, interactor: interactor, router: router)
        resetPasswordVC.presenter = presenter
        let backButton = UIBarButtonItem(image: UIImage(named: "BackBtn"), style: .plain, target: self, action: #selector(backButtonPressed))
        resetPasswordVC.navigationItem.leftBarButtonItem = backButton
        ResetPasswordVCBuilder.backButtonPressedClosure = { [weak resetPasswordVC] in
            resetPasswordVC?.backBtnPressed()
        }
        return resetPasswordVC
    }
    
    @objc static func backButtonPressed() {
        backButtonPressedClosure?()
    }
    
}
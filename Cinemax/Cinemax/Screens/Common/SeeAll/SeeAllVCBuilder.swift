//
//  SeeAllVCBuilder.swift
//  Cinemax
//
//  Created by IPS-161 on 19/03/24.
//

import Foundation
import UIKit

public final class SeeAllVCBuilder {
    
    static var backButtonPressedClosure : (()->())?
    
    static func build() -> UIViewController {
        let storyboard = UIStoryboard.Common
        let seeAllVC = storyboard.instantiateViewController(withIdentifier: "SeeAllVC") as! SeeAllVC
        let interactor = SeeAllVCInteractor(movieServiceManager: MoviesServiceManager.shared)
        let router = SeeAllVCRouter(viewController: seeAllVC)
        let presenter = SeeAllVCPresenter(view: seeAllVC, interactor: interactor, router: router)
        seeAllVC.presenter = presenter
        let backButton = UIBarButtonItem(image: UIImage(named: "BackBtn"), style: .plain, target: self, action: #selector(backButtonPressed))
        seeAllVC.navigationItem.leftBarButtonItem = backButton
        SeeAllVCBuilder.backButtonPressedClosure = { [weak seeAllVC] in
            seeAllVC?.backBtnPressed()
        }
        return seeAllVC
    }
    
    @objc static func backButtonPressed() {
        backButtonPressedClosure?()
    }
    
}

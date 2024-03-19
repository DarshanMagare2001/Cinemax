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
        //        let interactor = DetailVCInteractor(moviesServiceManager: MoviesServiceManager.shared)
        //        let presenter = DetailVCPresenter(view: detailVC, interactor: interactor, movieData: movieData)
        //        detailVC.presenter = presenter
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

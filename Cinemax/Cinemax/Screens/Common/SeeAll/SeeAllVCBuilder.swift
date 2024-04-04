//
//  SeeAllVCBuilder.swift
//  Cinemax
//
//  Created by IPS-161 on 19/03/24.
//

import Foundation
import UIKit

public final class SeeAllVCBuilder {
    
    static var seeAllVCStack: [SeeAllVC] = []
    static var backButtonPressedClosure : (()->())?
    
    static func build(genreId: Int?,page: Int?,searchText: String?,movieId: Int?,seeAllVCInputs: SeeAllVCInputs?) -> UIViewController {
        let storyboard = UIStoryboard.Common
        let seeAllVC = storyboard.instantiateViewController(withIdentifier: "SeeAllVC") as! SeeAllVC
        let interactor = SeeAllVCInteractor(movieServiceManager: MoviesServiceManager.shared)
        let router = SeeAllVCRouter(viewController: seeAllVC)
        let presenter = SeeAllVCPresenter(view: seeAllVC, interactor: interactor, router: router)
        presenter.page = page
        presenter.searchText = searchText
        presenter.movieId = movieId
        presenter.genreId = genreId
        presenter.seeAllVCInputs = seeAllVCInputs
        if let seeAllVCInputs = seeAllVCInputs {
            presenter.moviesHeadline = seeAllVCInputs.rawValue
        }
        seeAllVC.presenter = presenter
        let backButton = UIBarButtonItem(image: UIImage(named: "BackBtn"), style: .plain, target: self, action: #selector(backButtonPressed))
        seeAllVC.navigationItem.leftBarButtonItem = backButton
        SeeAllVCBuilder.backButtonPressedClosure = { [weak seeAllVC] in
            if let lastSeeAllVC = seeAllVCStack.popLast(){
                lastSeeAllVC.backBtnPressed()
            }
        }
        seeAllVCStack.append(seeAllVC)
        return seeAllVC
    }
    
    @objc static func backButtonPressed() {
        backButtonPressedClosure?()
    }
    
}

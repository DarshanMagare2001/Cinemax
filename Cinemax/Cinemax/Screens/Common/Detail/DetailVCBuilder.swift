//
//  DetailVCBuilder.swift
//  Cinemax
//
//  Created by IPS-161 on 14/03/24.
//

import Foundation
import UIKit

public final class DetailVCBuilder {
    
    static var backButtonPressedClosure : (()->())?
    
    static func build(movieData: MasterMovieModelResult?) -> UIViewController {
        let storyboard = UIStoryboard.Common
        let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        let interactor = DetailVCInteractor(moviesServiceManager: MoviesServiceManager.shared)
        let presenter = DetailVCPresenter(view: detailVC, interactor: interactor, movieData: movieData)
        detailVC.presenter = presenter
        if let movieData = movieData {
            detailVC.title = movieData.title
        }
        let backButton = UIBarButtonItem(image: UIImage(named: "BackBtn"), style: .plain, target: self, action: #selector(backButtonPressed))
        detailVC.navigationItem.leftBarButtonItem = backButton
        DetailVCBuilder.backButtonPressedClosure = { [weak detailVC] in
            detailVC?.backBtnPressed()
        }
        return detailVC
    }
    
    @objc static func backButtonPressed() {
        backButtonPressedClosure?()
    }
    
}

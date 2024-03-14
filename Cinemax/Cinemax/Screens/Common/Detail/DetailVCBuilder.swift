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
    
    static func build() -> UIViewController {
        let storyboard = UIStoryboard.Common
        let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        //        let interactor = EditProfileVCInteractor()
        //        editProfileVC.presenterProducer = {
        //            EditProfileVCPresenter(view: editProfileVC, interactor: interactor, input: $0)
        //        }
        //        editProfileVC.title = "EditProfile"
        //        let backButton = UIBarButtonItem(image: UIImage(named: "BackBtn"), style: .plain, target: self, action: #selector(backButtonPressed))
        //        editProfileVC.navigationItem.leftBarButtonItem = backButton
        //        EditProfileVCBuilder.backButtonPressedClosure = { [weak editProfileVC] in
        //            editProfileVC?.backBtnPressed()
        //        }
        return detailVC
    }
    
    @objc static func backButtonPressed() {
        backButtonPressedClosure?()
    }
    
}

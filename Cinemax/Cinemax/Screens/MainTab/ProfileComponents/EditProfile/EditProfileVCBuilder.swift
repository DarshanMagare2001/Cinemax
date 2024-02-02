//
//  EditProfileVCBuilder.swift
//  Cinemax
//
//  Created by IPS-161 on 02/02/24.
//

import Foundation
import UIKit

public final class EditProfileVCBuilder {
    
    static var backButtonPressedClosure : (()->())?
    
    static func build() -> UIViewController {
        let storyboard = UIStoryboard.Profile
        let editProfileVC = storyboard.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        let interactor = EditProfileVCInteractor()
        let presenter = EditProfileVCPresenter(view: editProfileVC, interactor: interactor)
        editProfileVC.presenter = presenter
        editProfileVC.title = "EditProfile"
        let backButton = UIBarButtonItem(image: UIImage(named: "BackBtn"), style: .plain, target: self, action: #selector(backButtonPressed))
        editProfileVC.navigationItem.leftBarButtonItem = backButton
        EditProfileVCBuilder.backButtonPressedClosure = { [weak editProfileVC] in
            editProfileVC?.backBtnPressed()
        }
        return editProfileVC
    }
    
    @objc static func backButtonPressed() {
        backButtonPressedClosure?()
    }
    
}


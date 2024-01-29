//
//  CreatenewpasswordVCBuilder.swift
//  Cinemax
//
//  Created by IPS-161 on 29/01/24.
//

import Foundation
import UIKit

public final class CreatenewpasswordVCBuilder {
    
    static var backButtonPressedClosure : (()->())?
    
    static func build() -> UIViewController {
        let storyboard = UIStoryboard.Authentication
        let createnewpasswordVC = storyboard.instantiateViewController(withIdentifier: "CreatenewpasswordVC") as! CreatenewpasswordVC
        
        let backButton = UIBarButtonItem(image: UIImage(named: "BackBtn"), style: .plain, target: self, action: #selector(backButtonPressed))
        createnewpasswordVC.navigationItem.leftBarButtonItem = backButton
        CreatenewpasswordVCBuilder.backButtonPressedClosure = { [weak createnewpasswordVC] in
            createnewpasswordVC?.backBtnPressed()
        }
        
        return createnewpasswordVC
    }
    
    @objc static func backButtonPressed() {
        backButtonPressedClosure?()
    }
}

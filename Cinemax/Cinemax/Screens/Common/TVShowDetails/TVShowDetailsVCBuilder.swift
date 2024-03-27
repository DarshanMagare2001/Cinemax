//
//  TVShowDetailsVCBuilder.swift
//  Cinemax
//
//  Created by IPS-161 on 27/03/24.
//


import Foundation
import UIKit

public final class TVShowDetailsVCBuilder {
    
    static var tvShowDetailsVCStack: [TVShowDetailsVC] = []
    static var backButtonPressedClosure : (()->())?
    
    static func build() -> UIViewController {
        let storyboard = UIStoryboard.Common
        let tvShowDetailsVC = storyboard.instantiateViewController(withIdentifier: "TVShowDetailsVC") as! TVShowDetailsVC
        let backButton = UIBarButtonItem(image: UIImage(named: "BackBtn"), style: .plain, target: self, action: #selector(backButtonPressed))
        tvShowDetailsVC.navigationItem.leftBarButtonItem = backButton
        TVShowDetailsVCBuilder.backButtonPressedClosure = { [weak tvShowDetailsVC] in
            if let lastTVShowDetailsVC = tvShowDetailsVCStack.popLast(){
                lastTVShowDetailsVC.backBtnPressed()
            }
        }
        tvShowDetailsVCStack.append(tvShowDetailsVC)
        return tvShowDetailsVC
    }
    
    @objc static func backButtonPressed() {
        backButtonPressedClosure?()
    }
    
}


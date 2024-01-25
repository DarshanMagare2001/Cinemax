//
//  OnboardingVC.swift
//  Cinemax
//
//  Created by IPS-161 on 24/01/24.
//

import UIKit

protocol OnboardingVCProtocol: class {
    func updateUI()
}

class OnboardingVC: UIViewController {
    
    var presenter: OnboardingVCPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidload()
    }
    
}

extension OnboardingVC: OnboardingVCProtocol {
    func updateUI(){
        print("updateUI")
    }
}

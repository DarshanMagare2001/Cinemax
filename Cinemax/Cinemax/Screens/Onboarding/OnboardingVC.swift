//
//  OnboardingVC.swift
//  Cinemax
//
//  Created by IPS-161 on 24/01/24.
//

import UIKit
import JXPageControl

protocol OnboardingVCProtocol: class {
    func updateUI()
    func nextOnboarding()
}

class OnboardingVC: UIViewController {
    
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var frontImg: UIImageView!
    @IBOutlet weak var frontImgView: UIView!
    @IBOutlet weak var headlineLbl: UILabel!
    @IBOutlet weak var subHeadlineLbl: UILabel!
    @IBOutlet weak var pageControl: JXPageControlEllipse!
    
    var presenter: OnboardingVCPresenterProtocol?
    var onboardingScreenIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidload()
        pageControl.isAnimation  = true
        
    }
    
    @IBAction func nxtBtnPressed(_ sender: UIButton) {
        nextOnboarding()
    }
    
}

extension OnboardingVC: OnboardingVCProtocol {
    
    func nextOnboarding(){
        guard onboardingScreenIndex < 2 else {
            return
        }
        onboardingScreenIndex += 1
        updateUI()
        let progress = CGFloat(onboardingScreenIndex) / CGFloat(presenter?.datasource.count ?? 1)
        pageControl.progress = progress
        pageControl.currentPage = onboardingScreenIndex
    }
    
    
    func updateUI(){
        guard let datasource = presenter?.datasource[onboardingScreenIndex] else {
            return
        }
        
        if onboardingScreenIndex == 0 {
            backgroundImg.isHidden = false
            frontImg.isHidden = true
            backgroundImg.image = datasource.img
        }else{
            backgroundImg.isHidden = true
            frontImg.isHidden = false
            frontImg.image = datasource.img
            headlineLbl.text = datasource.headline
            subHeadlineLbl.text = datasource.subHeadline
        }
    }
    
}



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
    
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var frontImg: UIImageView!
    @IBOutlet weak var frontImgView: UIView!
    @IBOutlet weak var headlineLbl: UILabel!
    @IBOutlet weak var subHeadlineLbl: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var presenter: OnboardingVCPresenterProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidload()
    }
    
    @IBAction func nxtBtnPressed(_ sender: UIButton) {
        
    }
    
    
}

extension OnboardingVC: OnboardingVCProtocol {
    func updateUI(){
        guard let datasource = presenter?.datasource[0] else {
            return
        }
        backgroundImg.image = datasource.img
        headlineLbl.text = datasource.headline
        subHeadlineLbl.text = datasource.subHeadline
    }
}

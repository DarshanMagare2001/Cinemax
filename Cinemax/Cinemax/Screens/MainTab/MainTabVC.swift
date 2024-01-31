//
//  ViewController.swift
//  Cinemax
//
//  Created by IPS-161 on 24/01/24.
//

import UIKit

class MainTabVC: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var homeBtnLbl: UILabel!
    @IBOutlet weak var searchBtnLbl: UILabel!
    @IBOutlet weak var downloadBtnLbl: UILabel!
    @IBOutlet weak var profileBtnLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeBtnLbl.isHidden = true
//        searchBtnLbl.isHidden = true
        downloadBtnLbl.isHidden = true
        profileBtnLbl.isHidden = true
    }
    
    
    
}


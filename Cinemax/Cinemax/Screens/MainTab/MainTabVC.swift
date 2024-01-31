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
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var homeBtnView: RoundedCornerView!
    @IBOutlet weak var searchBtnView: RoundedCornerView!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var downloadBtnView: RoundedCornerView!
    @IBOutlet weak var downloadBtn: UIButton!
    @IBOutlet weak var personBtnView: RoundedCornerView!
    @IBOutlet weak var personBtn: UIButton!
    
    var isHomeTabShow = true {
        didSet{
            homeBtnView.borderColor = isHomeTabShow ? UIColor.appBlue! : UIColor.black
            homeBtnView.backgroundColor = isHomeTabShow ? UIColor.appDark1! : UIColor.black
            homeBtn.tintColor = isHomeTabShow ? UIColor.appBlue! : UIColor.black
            homeBtnLbl.textColor = isHomeTabShow ? UIColor.appBlue! : UIColor.black
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
    }
    
    
    @IBAction func homeBtnPressed(_ sender: UIButton) {
        
    }
    
    
    @IBAction func searchBtnPressed(_ sender: UIButton) {
        
    }
    
    
    @IBAction func downloadBtnPressed(_ sender: UIButton) {
        
    }
    
    
    @IBAction func personBtnPressed(_ sender: UIButton) {
        
    }
    
}

extension MainTabVC {
    private func setUpTabs(){
        isHomeTabShow = true
        homeBtnLbl.isHidden = false
        searchBtnLbl.isHidden = true
        downloadBtnLbl.isHidden = true
        profileBtnLbl.isHidden = true
    }
}

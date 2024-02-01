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
            homeBtnLbl.isHidden = isHomeTabShow ? false : true
            homeBtnView.backgroundColor = isHomeTabShow ? UIColor.appDark1! : UIColor.black
            homeBtn.tintColor = isHomeTabShow ? UIColor.appBlue! : UIColor.gray
            homeBtnLbl.textColor = isHomeTabShow ? UIColor.appBlue! : UIColor.black
        }
    }
    
    
    var isSearchTabShow = true {
        didSet{
            searchBtnLbl.isHidden = isSearchTabShow ? false : true
            searchBtnView.backgroundColor = isSearchTabShow ? UIColor.appDark1! : UIColor.black
            searchBtn.tintColor = isSearchTabShow ? UIColor.appBlue! : UIColor.gray
            searchBtnLbl.textColor = isSearchTabShow ? UIColor.appBlue! : UIColor.black
        }
    }
    
    var isDownloadTabShow = true {
        didSet{
            downloadBtnLbl.isHidden = isDownloadTabShow ? false : true
            downloadBtnView.backgroundColor = isDownloadTabShow ? UIColor.appDark1! : UIColor.black
            downloadBtn.tintColor = isDownloadTabShow ? UIColor.appBlue! : UIColor.gray
            downloadBtnLbl.textColor = isDownloadTabShow ? UIColor.appBlue! : UIColor.black
        }
    }
    
    var isProfileTabShow = true {
        didSet{
            profileBtnLbl.isHidden = isProfileTabShow ? false : true
            personBtnView.backgroundColor = isProfileTabShow ? UIColor.appDark1! : UIColor.black
            personBtn.tintColor = isProfileTabShow ? UIColor.appBlue! : UIColor.gray
            profileBtnLbl.textColor = isProfileTabShow ? UIColor.appBlue! : UIColor.black
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
    }
    
    
    @IBAction func homeBtnPressed(_ sender: UIButton) {
        isHomeTabShow = true
        isSearchTabShow = false
        isDownloadTabShow = false
        isProfileTabShow = false
    }
    
    
    @IBAction func searchBtnPressed(_ sender: UIButton) {
        isHomeTabShow = false
        isSearchTabShow = true
        isDownloadTabShow = false
        isProfileTabShow = false
    }
    
    
    @IBAction func downloadBtnPressed(_ sender: UIButton) {
        isHomeTabShow = false
        isSearchTabShow = false
        isDownloadTabShow = true
        isProfileTabShow = false
    }
    
    
    @IBAction func personBtnPressed(_ sender: UIButton) {
        isHomeTabShow = false
        isSearchTabShow = false
        isDownloadTabShow = false
        isProfileTabShow = true
    }
    
}

extension MainTabVC {
    private func setUpTabs(){
        isHomeTabShow = true
        isSearchTabShow = false
        isDownloadTabShow = false
        isProfileTabShow = false
    }
}

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
    
    var selectedTab: Tab = .home {
        didSet {
            updateTabUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
    }
    
    
    @IBAction func tabBtnPressed(_ sender: UIButton) {
        selectedTab = Tab(rawValue: sender.tag) ?? .home
    }
    
    
}

extension MainTabVC {
    private func setUpTabs() {
        selectedTab = .home
    }
    
    private func updateTabUI() {
        let tabs: [(UILabel, RoundedCornerView, UIButton)] = [
            (homeBtnLbl, homeBtnView, homeBtn),
            (searchBtnLbl, searchBtnView, searchBtn),
            (downloadBtnLbl, downloadBtnView, downloadBtn),
            (profileBtnLbl, personBtnView, personBtn)
        ]
        
        for (label, view, button) in tabs {
            let isSelectedTab = button.tag == selectedTab.rawValue
            label.isHidden = !isSelectedTab
            view.backgroundColor = isSelectedTab ? UIColor.appDark1! : UIColor.black
            button.tintColor = isSelectedTab ? UIColor.appBlue! : UIColor.gray
            label.textColor = isSelectedTab ? UIColor.appBlue! : UIColor.black
        }
    }
}

enum Tab: Int {
    case home = 0, search, download, profile
}

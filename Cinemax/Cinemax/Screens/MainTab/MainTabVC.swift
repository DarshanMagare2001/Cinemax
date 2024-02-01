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
            setupScreens(selectedTabIndex:selectedTab.rawValue)
        }
    }
    
    private func setupScreens(selectedTabIndex:Int){
        var viewController = UIViewController()
        if selectedTabIndex == 0 {
            viewController = HomeVCBuilder.build(factor: NavigationFactory.build(rootView:))
        }else if selectedTabIndex == 1 {
            viewController = SearchVCBuilder.build(factor: NavigationFactory.build(rootView:))
        }else if selectedTabIndex == 2 {
            viewController = DownloadVCBuilder.build(factor: NavigationFactory.build(rootView:))
        }else if selectedTabIndex == 3 {
            viewController = ProfileVCBuilder.build(factor: NavigationFactory.build(rootView:))
        }
        
        mainView.addSubview(viewController.view)
        // Notify the HomeVC that it has been added as a child
        addChild(viewController)
        // Set constraints for the HomeVC's view within mainView
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewController.view.topAnchor.constraint(equalTo: mainView.topAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            viewController.view.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            viewController.view.trailingAnchor.constraint(equalTo: mainView.trailingAnchor)
        ])
        // Notify the HomeVC that it has been added
        viewController.didMove(toParent: self)
    }
    
    
}

enum Tab: Int {
    case home = 0, search, download, profile
}

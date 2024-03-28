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
    
    // Container view to hold child view controllers
    private var containerViewController: UIViewController?
    
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
        
        // Update the content for the selected tab
        updateContentForSelectedTab()
    }
    
    private func updateContentForSelectedTab() {
        switch selectedTab {
        case .home:
            showChildViewController(HomeVCBuilder.build(factor: NavigationFactory.build(rootView:)))
        case .search:
            showChildViewController(SearchVCBuilder.build(factor: NavigationFactory.build(rootView:)))
        case .download:
            showChildViewController(DownloadVCBuilder.build(factor: NavigationFactory.build(rootView:)))
        case .profile:
            showChildViewController(ProfileVCBuilder.build(factor: NavigationFactory.build(rootView:)))
        }
    }
    
    private func showChildViewController(_ viewController: UIViewController) {
        // Remove the current child view controller if it exists
        containerViewController?.removeFromParent()
        containerViewController?.view.removeFromSuperview()
        
        // Add the new child view controller
        addChild(viewController)
        mainView.addSubview(viewController.view)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewController.view.topAnchor.constraint(equalTo: mainView.topAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            viewController.view.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            viewController.view.trailingAnchor.constraint(equalTo: mainView.trailingAnchor)
        ])
        viewController.didMove(toParent: self)
        
        // Update the container view controller reference
        containerViewController = viewController
    }
}

enum Tab: Int {
    case home = 0, search, download, profile
}

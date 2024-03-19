//
//  SeeAllVC.swift
//  Cinemax
//
//  Created by IPS-161 on 18/03/24.
//

import UIKit

class SeeAllVC: UIViewController {
    
    @IBOutlet weak var sortByLbl: UILabel!
    var sortByString : String? {
        didSet{
            sortByLbl.text = sortByString ?? ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func gridLayoutBtnPressed(_ sender: UIButton) {
        // Implement grid layout button action
    }
    
    @IBAction func sortedBtnPressed(_ sender: UIButton) {
        showSortingMenu(sender:sender)
    }
    
    func backBtnPressed(){
        navigationController?.popViewController(animated: true)
    }
    
    private func showSortingMenu(sender:UIButton){
        // Define actions for sorting
        let sortByRatingAction = UIAction(title: "Rating", image: UIImage(systemName: "star.fill")) { _ in
            self.sortByString = "Sort by Rating"
        }
        let sortByNameAZAction = UIAction(title: "Name A-Z", image: UIImage(systemName: "abc")) { _ in
            self.sortByString = "Sort by Name A-Z"
        }
        let sortByNameZAAction = UIAction(title: "Name Z-A", image: UIImage(systemName: "abc")) { _ in
            self.sortByString = "Sort by Name Z-A"
        }
        // Create a menu with sorting options
        let sortingMenu = UIMenu(title: "Sort By", children: [sortByRatingAction, sortByNameAZAction,sortByNameZAAction])
        // Show menu
        let menuButton = sender
        menuButton.showsMenuAsPrimaryAction = true
        menuButton.menu = sortingMenu
    }
}

//
//  SeeAllVC.swift
//  Cinemax
//
//  Created by IPS-161 on 18/03/24.
//

import UIKit

protocol SeeAllVCProtocol: AnyObject {
    func registerXibs()
    func updateCollectionView()
}

class SeeAllVC: UIViewController {
    
    @IBOutlet weak var moviesHeadlineLbl: UILabel!
    @IBOutlet weak var moviesCollectionviewOutlet: UICollectionView!
    @IBOutlet weak var sortByLbl: UILabel!
    var sortByString : String? {
        didSet{
            sortByLbl.text = sortByString ?? ""
        }
    }
    var presenter: SeeAllVCPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidload()
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
}

extension SeeAllVC : SeeAllVCProtocol {
    func registerXibs(){
        let nib = UINib(nibName: "MoviesCollectionViewCell", bundle: nil)
        moviesCollectionviewOutlet.register(nib, forCellWithReuseIdentifier: "MoviesCollectionViewCell")
    }
    func updateCollectionView(){
        moviesCollectionviewOutlet.reloadData()
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

extension SeeAllVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.moviesDatasource.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewCell", for: indexPath) as!
        MoviesCollectionViewCell
        guard let cellData = presenter?.moviesDatasource[indexPath.row] else {
            return UICollectionViewCell()
        }
        cell.configure(movie: cellData)
        return cell
    }
}

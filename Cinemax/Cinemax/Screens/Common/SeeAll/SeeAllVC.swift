//
//  SeeAllVC.swift
//  Cinemax
//
//  Created by IPS-161 on 18/03/24.
//

import UIKit
import RxSwift

protocol SeeAllVCProtocol: AnyObject {
    func updateUI()
    func registerXibs()
    func setupFlowlayout()
    func updateCollectionView()
}

class SeeAllVC: UIViewController {
    
    @IBOutlet weak var moviesHeadlineLbl: UILabel!
    @IBOutlet weak var moviesCollectionviewOutlet: UICollectionView!
    @IBOutlet weak var sortByLbl: UILabel!
    @IBOutlet weak var gridBtn: UIButton!
    var sortByString : String? {
        didSet{
            sortByLbl.text = sortByString ?? ""
        }
    }
    var isGridLayout : Bool = true {
        didSet{
            DispatchQueue.main.async { [weak self] in
                self?.setupFlowlayout()
                self?.moviesCollectionviewOutlet.reloadData()
                self?.gridBtn.setImage(UIImage(systemName: (self!.isGridLayout ? "square.grid.3x3.fill":"line.3.horizontal")), for: .normal)
            }
        }
    }
    var presenter: SeeAllVCPresenterProtocol?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidload()
    }
    
    @IBAction func gridLayoutBtnPressed(_ sender: UIButton) {
        isGridLayout.toggle()
    }
    
    @IBAction func sortedBtnPressed(_ sender: UIButton) {
        showSortingMenu(sender:sender)
    }
    
    func backBtnPressed(){
        navigationController?.popViewController(animated: true)
    }
}

extension SeeAllVC : SeeAllVCProtocol {
    
    func updateUI(){
        if let moviesHeadline = presenter?.moviesHeadline {
            moviesHeadlineLbl.text =  moviesHeadline
        }
    }
    
    func registerXibs(){
        let nib1 = UINib(nibName: "MoviesCollectionViewCell", bundle: nil)
        let nib2 = UINib(nibName: "MoviesCollectionViewDetailCell", bundle: nil)
        moviesCollectionviewOutlet.register(nib1, forCellWithReuseIdentifier: "MoviesCollectionViewCell")
        moviesCollectionviewOutlet.register(nib2, forCellWithReuseIdentifier: "MoviesCollectionViewDetailCell")
    }
    
    func setupFlowlayout(){
        let flowLayout = UICollectionViewFlowLayout()
        if isGridLayout {
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.minimumLineSpacing = 15
            let cellWidth = (moviesCollectionviewOutlet.frame.size.width / 2) - 8
            flowLayout.itemSize = CGSize(width: cellWidth, height: 300)
            moviesCollectionviewOutlet.collectionViewLayout = flowLayout
        }else{
            let cellWidth = moviesCollectionviewOutlet.frame.size.width - 5
            flowLayout.itemSize = CGSize(width: cellWidth, height: 300)
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.minimumLineSpacing = 15
            moviesCollectionviewOutlet.collectionViewLayout = flowLayout
        }
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
        if isGridLayout {
            return presenter?.moviesDatasource.count ?? 0
        }else{
            return presenter?.moviesDatasourceIndetail.count ?? 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isGridLayout {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewCell", for: indexPath) as!
            MoviesCollectionViewCell
            guard let cellData = presenter?.moviesDatasource[indexPath.row] else {
                return UICollectionViewCell()
            }
            cell.configure(movie: cellData)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewDetailCell", for: indexPath) as! MoviesCollectionViewDetailCell
            if let movie = presenter?.moviesDatasourceIndetail[indexPath.row] {
                DispatchQueue.main.async { [weak self] in
                    cell.configure(movie: movie)
                }
            }
            return cell
        }
        return UICollectionViewCell()
    }
}

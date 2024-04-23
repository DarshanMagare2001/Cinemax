//
//  WishListVC.swift
//  Cinemax
//
//  Created by IPS-161 on 03/04/24.
//

import UIKit

protocol WishListVCProtocol: AnyObject {
    func registerXibs()
    func setupFlowlayout()
    func updateUI()
}

class WishListVC: UIViewController {
    
    @IBOutlet weak var moviesBtn: RoundedButton!
    @IBOutlet weak var tvShowsBtn: RoundedButton!
    @IBOutlet weak var wishListCountLbl: UILabel!
    @IBOutlet weak var moviesAndTVShowsCV: UICollectionView!
    
    var presenter: WishListVCPresenterProtocol?
    var isMoviesSelected = true {
        didSet{
            DispatchQueue.main.async {
                if self.isMoviesSelected {
                    self.wishListCountLbl.text = "Movies"
                }else{
                    self.wishListCountLbl.text = "TV Shows"
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidload()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        presenter?.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func contentToggleBtn(_ sender: UIButton) {
        toggleContent(tag: sender.tag)
        isMoviesSelected.toggle()
    }
    
}

extension WishListVC: WishListVCProtocol {
    
    
    func registerXibs(){
        let nib2 = UINib(nibName: "MoviesCollectionViewDetailCell", bundle: nil)
        moviesAndTVShowsCV.register(nib2, forCellWithReuseIdentifier: "MoviesCollectionViewDetailCell")
    }
    
    func setupFlowlayout(){
        let flowLayout = UICollectionViewFlowLayout()
        let cellWidth = moviesAndTVShowsCV.frame.size.width - 5
        let height = (moviesAndTVShowsCV.frame.size.height/2) - 5
        flowLayout.itemSize = CGSize(width: cellWidth, height: height)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 15
        moviesAndTVShowsCV.collectionViewLayout = flowLayout
    }
    
    func updateUI(){
        moviesAndTVShowsCV.reloadData()
    }
    
    private func toggleContent(tag:Int){
        if tag == 0 {
            UIView.transition(with: self.moviesBtn,
                              duration: 0.3,
                              options: .transitionFlipFromRight,
                              animations: {
                self.moviesBtn.backgroundColor = .appBlue
                self.moviesBtn.isUserInteractionEnabled = false
                self.tvShowsBtn.isUserInteractionEnabled = true
                self.tvShowsBtn.backgroundColor = .clear
            },completion: nil)
        }else{
            UIView.transition(with: self.tvShowsBtn,
                              duration: 0.3,
                              options: .transitionFlipFromLeft,
                              animations: {
                self.tvShowsBtn.backgroundColor = .appBlue
                self.moviesBtn.isUserInteractionEnabled = true
                self.tvShowsBtn.isUserInteractionEnabled = false
                self.moviesBtn.backgroundColor = .clear
            },completion: nil)
        }
    }
    
}

extension WishListVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.datasource.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewDetailCell", for: indexPath) as! MoviesCollectionViewDetailCell
        if let cellData = presenter?.datasource[indexPath.row] {
            cell.configure(cellData: cellData)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movieId = presenter?.datasource[indexPath.row].movieId {
            presenter?.gotoDetailVC(movieId:movieId)
        }
    }
    
}

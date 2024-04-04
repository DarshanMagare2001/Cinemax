//
//  GenresVC.swift
//  Cinemax
//
//  Created by IPS-161 on 03/04/24.
//

import UIKit

protocol GenresVCProtocol: AnyObject {
    func updateUI()
}

class GenresVC: UIViewController {
    
    @IBOutlet weak var moviesBtn: RoundedButton!
    @IBOutlet weak var tvShowsBtn: RoundedButton!
    @IBOutlet weak var genresCollectionView: UICollectionView!
    var presenter: GenresVCPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFlowlayout()
        presenter?.viewDidload()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    @IBAction func contentToggleBtn(_ sender: UIButton) {
        toggleContent(tag: sender.tag)
    }
    
}

extension GenresVC: GenresVCProtocol {
    
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
    
    func setupFlowlayout(){
        let flowLayout = UICollectionViewFlowLayout()
        let width = (genresCollectionView.bounds.width / 3) - 8
        let height = (genresCollectionView.bounds.height / 10) - 10
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.itemSize = CGSize(width: width, height: height)
        genresCollectionView.collectionViewLayout = flowLayout
    }
    
    func updateUI(){
        genresCollectionView.reloadData()
    }
    
}

extension GenresVC: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.genresDatasource.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenresVCCVCell", for: indexPath) as! GenresVCCVCell
        guard let cellData = presenter?.genresDatasource[indexPath.row] else {
            return UICollectionViewCell()
        }
        cell.cellNameLbl.text = cellData.genresName
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cellData = presenter?.genresDatasource[indexPath.row]{
            presenter?.gotoSeeAllVC(genreId: Int(cellData.genresId), page: 1, searchText: "", movieId: 0, seeAllVCInputs: SeeAllVCInputs.fetchMoviesByGenres)
        }
    }
    
}

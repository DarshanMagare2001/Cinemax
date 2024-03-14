//
//  MoviesCell.swift
//  Cinemax
//
//  Created by IPS-161 on 06/02/24.
//

import UIKit

class MoviesCell: UITableViewCell {
    
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    
    var seeAllBtnPressedClosure : (()->())?
    
    var cellTitleData : String? {
        didSet{
            self.cellTitle.text = cellTitleData
        }
    }
    
    var dataSource : MasterMovieModel? {
        didSet{
            collectionViewOutlet.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionViewOutlet.delegate = self
        collectionViewOutlet.dataSource = self
        let nib = UINib(nibName: "MoviesCollectionViewCell", bundle: nil)
        collectionViewOutlet.register(nib, forCellWithReuseIdentifier: "MoviesCollectionViewCell")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
    @IBAction func seeAllBtnPressed(_ sender: UIButton) {
        seeAllBtnPressedClosure?()
    }
    
}

extension MoviesCell : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewCell", for: indexPath) as! MoviesCollectionViewCell
        guard let cellData = dataSource?.results[indexPath.row] else {
            return UICollectionViewCell()
        }
        cell.configure(movie: cellData)
        return cell
    }
}

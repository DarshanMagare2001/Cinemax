//
//  MoviesCollectionViewCell.swift
//  Cinemax
//
//  Created by IPS-161 on 06/02/24.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImg: UIImageView!
    @IBOutlet weak var cellNameLbl: UILabel!
    @IBOutlet weak var cellLanguageLbl: UILabel!
    @IBOutlet weak var cellRatingLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(cellData:MoviesCollectionViewCellModel){
        DispatchQueue.main.async { [weak self] in
            self?.cellImg.loadImage(urlString: cellData.cellImgUrl, placeholder: "frame.fill")
            self?.cellNameLbl.text = cellData.cellNameLblText
            self?.cellLanguageLbl.text = cellData.cellLanguageLblText
            self?.cellRatingLbl.text = String(format: "%.1f",cellData.cellRatingLblText)
        }
    }
    
}

struct MoviesCollectionViewCellModel {
    let cellImgUrl: String
    let cellNameLblText: String
    let cellLanguageLblText: String
    let cellRatingLblText: Double
    init(cellImgUrl: String,cellNameLblText: String,cellLanguageLblText: String,cellRatingLblText: Double){
        self.cellImgUrl = "https://image.tmdb.org/t/p/w500\(cellImgUrl)"
        self.cellNameLblText = cellNameLblText
        self.cellLanguageLblText = cellLanguageLblText
        self.cellRatingLblText = cellRatingLblText
    }
}

//
//  TVShowSimilarCollectionCell.swift
//  Cinemax
//
//  Created by IPS-161 on 28/03/24.
//

import UIKit

class TVShowSimilarCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var tvShowImg: UIImageView!
    
    override func prepareForReuse() {
        tvShowImg.image = nil
    }
    
    func configure(tvShow:TVShowsResponseModelResult){
        let tvShowForegroundImgUrl = "https://image.tmdb.org/t/p/w500\(tvShow.posterPath ?? "")"
        tvShowImg.loadImage(urlString: tvShowForegroundImgUrl, placeholder:"frame.fill")
    }
    
}

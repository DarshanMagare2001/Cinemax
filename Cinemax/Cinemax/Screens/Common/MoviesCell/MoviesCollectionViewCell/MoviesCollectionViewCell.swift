//
//  MoviesCollectionViewCell.swift
//  Cinemax
//
//  Created by IPS-161 on 06/02/24.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var movieNameLbl: UILabel!
    @IBOutlet weak var movieGenereLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(movie:MasterMovieModelResult){
        DispatchQueue.main.async { [weak self] in
            let movieImgUrl = "https://image.tmdb.org/t/p/w500\(movie.posterPath)"
            self?.movieImg.loadImage(urlString: movieImgUrl, placeholder: "frame.fill")
            let movieName = movie.title
            let movieLanguage = movie.originalLanguage
            self?.movieNameLbl.text = movieName
            self?.movieGenereLbl.text = movieLanguage
        }
    }
    
}

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
    @IBOutlet weak var moviesRatingLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(movie:MasterMovieModelResult){
        DispatchQueue.main.async { [weak self] in
            let movieImgUrl = "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")"
            self?.movieImg.loadImage(urlString: movieImgUrl, placeholder: "frame.fill")
            let movieLanguage = movie.originalLanguage
            let movieRating = String(format: "%.1f", movie.voteAverage ?? 0.0)
            let movieTitle = movie.title
            let movieName = movie.name
            self?.movieNameLbl.text = (movieTitle == nil) ? movieName : movieTitle
            self?.movieGenereLbl.text = movieLanguage
            self?.moviesRatingLbl.text = "\(movieRating)"
        }
    }
    
}

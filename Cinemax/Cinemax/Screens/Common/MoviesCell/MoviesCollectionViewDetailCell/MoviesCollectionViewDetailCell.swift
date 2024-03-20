//
//  MoviesCollectionViewDetailCell.swift
//  Cinemax
//
//  Created by IPS-161 on 19/03/24.
//

import UIKit

class MoviesCollectionViewDetailCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var movieNameLbl: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieDuration: UILabel!
    @IBOutlet weak var movieGenereLbl: UILabel!
    @IBOutlet weak var movieLanguageLbl: UILabel!
    @IBOutlet weak var movieOverviewLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(movie:MovieDetailsModel){
        if let movieImgUrl = movie.posterPath,
           let movieName = movie.title,
           let moviereleaseDate = movie.releaseDate,
           let movieDuration = movie.runtime,
           let movieGenere = movie.genres?[0].name,
           let movieLanguage = movie.originalLanguage,
           let movieOverview = movie.overview{
            let imgUrl = "https://image.tmdb.org/t/p/w500\(movieImgUrl)"
            self.movieImg.loadImage(urlString: imgUrl, placeholder: "frame.fill")
            self.movieNameLbl.text = movieName
            self.movieReleaseDate.text = moviereleaseDate
            self.movieDuration.text = "\(movieDuration) mins"
            self.movieGenereLbl.text = movieGenere
            self.movieLanguageLbl.text = movieLanguage
            self.movieOverviewLbl.text = movieOverview
        }
    }
    
}
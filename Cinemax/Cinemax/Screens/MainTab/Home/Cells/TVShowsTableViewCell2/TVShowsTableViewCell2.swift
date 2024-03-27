//
//  TVShowsTableViewCell.swift
//  Cinemax
//
//  Created by IPS-161 on 26/03/24.
//

import UIKit

class TVShowsTableViewCell2: UITableViewCell {
    @IBOutlet weak var tvShowPosterImgView: UIImageView!
    @IBOutlet weak var tvShowNameLbl: UILabel!
    @IBOutlet weak var tvShowRatingLbl: UILabel!
    var playBtnPressedClosure : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction func playBtnPressed(_ sender: UIButton) {
        playBtnPressedClosure?()
    }
    
    func configure(tvShow:TVShowsResponseModelResult){
        let tvShowPosterImgUrl = "https://image.tmdb.org/t/p/w500\(tvShow.posterPath)"
        let movieRating = String(format: "%.1f",tvShow.voteAverage)
        DispatchQueue.main.async { [weak self] in
            self?.tvShowPosterImgView.loadImage(urlString: tvShowPosterImgUrl, placeholder: "frame.fill")
            self?.tvShowNameLbl.text = tvShow.name
            self?.tvShowRatingLbl.text = movieRating
        }
    }
    
}

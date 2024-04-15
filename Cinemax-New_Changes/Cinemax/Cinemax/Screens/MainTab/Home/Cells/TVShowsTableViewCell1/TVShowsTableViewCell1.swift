//
//  TVShowsTableViewCell1.swift
//  Cinemax
//
//  Created by IPS-161 on 26/03/24.
//

import UIKit

class TVShowsTableViewCell1: UITableViewCell {
    
    @IBOutlet weak var tvShowBackgroundImg: UIImageView!
    @IBOutlet weak var tvShowForegroundImg: UIImageView!
    @IBOutlet weak var tvShowNameLbl: UILabel!
    @IBOutlet weak var tvShowDescriptionLbl: UILabel!
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
        let tvShowBackgroundImgUrl = "https://image.tmdb.org/t/p/w500\(tvShow.backdropPath)"
        let tvShowForegroundImgUrl = "https://image.tmdb.org/t/p/w500\(tvShow.posterPath)"
        let name = tvShow.name
        let description = tvShow.overview
        DispatchQueue.main.async { [weak self] in
            self?.tvShowBackgroundImg.loadImage(urlString: tvShowBackgroundImgUrl, placeholder: "frame.fill")
            self?.tvShowForegroundImg.loadImage(urlString: tvShowForegroundImgUrl, placeholder: "frame.fill")
            self?.tvShowNameLbl.text = name
            self?.tvShowDescriptionLbl.text = description
        }
    }
    
}

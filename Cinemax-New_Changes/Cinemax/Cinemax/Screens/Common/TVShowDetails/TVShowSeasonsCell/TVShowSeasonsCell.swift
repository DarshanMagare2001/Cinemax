//
//  TVShowSeasonsCell.swift
//  Cinemax
//
//  Created by IPS-161 on 27/03/24.
//

import UIKit

class TVShowSeasonsCell: UITableViewCell {
    
    @IBOutlet weak var tvShowImg: UIImageView!
    @IBOutlet weak var seasonNameLbl: UILabel!
    @IBOutlet weak var seasonReleaseDateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction func playBtnPressed(_ sender: UIButton) {
        
    }
    
    func configure(season:Season,defaultPosterPath:String){
        let tvShowForegroundImgUrl = "https://image.tmdb.org/t/p/w500\(season.posterPath ?? (defaultPosterPath ?? ""))"
        let seasonName = season.name ?? ""
        let seasonReleaseDate = season.airDate ?? ""
        DispatchQueue.main.async { [weak self] in
            self?.tvShowImg.loadImage(urlString: tvShowForegroundImgUrl, placeholder: "frame.fill")
            self?.seasonNameLbl.text = seasonName
            self?.seasonReleaseDateLbl.text = seasonReleaseDate
        }
    }
    
}

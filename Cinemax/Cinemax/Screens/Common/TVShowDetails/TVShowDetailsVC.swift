//
//  TVShowDetailsVC.swift
//  Cinemax
//
//  Created by IPS-161 on 27/03/24.
//

import UIKit

protocol TVShowDetailsVCProtocol: AnyObject {
    func updateUI(tvShowDetails: TVShowDetailsResponseModel)
}

class TVShowDetailsVC: UIViewController {
    
    
    @IBOutlet weak var tvShowTitleLbl: UILabel!
    @IBOutlet weak var tvShowForegroundImg: UIImageView!
    @IBOutlet weak var tvShowRatingLbl: UILabel!
    @IBOutlet weak var tvShowsEpisodesLbl: UILabel!
    @IBOutlet weak var tvShowsReleaseDateLbl: UILabel!
    
    var presenter: TVShowDetailsVCPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidload()
    }
    
}

extension TVShowDetailsVC:  TVShowDetailsVCProtocol {
    
    func backBtnPressed(){
        navigationController?.popViewController(animated: true)
    }
    
    func updateUI(tvShowDetails: TVShowDetailsResponseModel){
        tvShowTitleLbl.text = tvShowDetails.name
        let tvShowForegroundImgUrl = "https://image.tmdb.org/t/p/w500\(tvShowDetails.posterPath ?? "")"
        tvShowForegroundImg.loadImage(urlString: tvShowForegroundImgUrl, placeholder: "frame.fill")
        let tvShowRating = String(format: "%.1f",tvShowDetails.voteAverage)
        tvShowRatingLbl.text = tvShowRating
        tvShowsEpisodesLbl.text = "\(tvShowDetails.numberOfEpisodes)"
        tvShowsReleaseDateLbl.text = tvShowDetails.firstAirDate.extractYearFromDateString() ?? ""
    }
    
}

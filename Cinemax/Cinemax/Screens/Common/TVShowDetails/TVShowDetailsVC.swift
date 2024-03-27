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
    @IBOutlet weak var tvShowOverviewLbl: UILabel!
    @IBOutlet weak var tvShowsSeasonsTBLViewOutlet: UITableView!
    
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
        tvShowOverviewLbl.text = tvShowDetails.overview ?? ""
        tvShowsSeasonsTBLViewOutlet.reloadData()
    }
    
}

extension TVShowDetailsVC: UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.tvShowDetails?.seasons.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TVShowSeasonsCell", for: indexPath) as! TVShowSeasonsCell
        guard let cellData = presenter?.tvShowDetails?.seasons[indexPath.row],
              let defaultPosterPath = presenter?.tvShow?.posterPath else {
                  return UITableViewCell()
              }
        cell.configure(season: cellData, defaultPosterPath: defaultPosterPath)
        return cell
    }
    
}

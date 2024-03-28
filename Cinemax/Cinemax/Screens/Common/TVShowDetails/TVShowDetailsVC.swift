//
//  TVShowDetailsVC.swift
//  Cinemax
//
//  Created by IPS-161 on 27/03/24.
//

import UIKit

protocol TVShowDetailsVCProtocol: AnyObject {
    func updateUI(tvShowDetails: TVShowDetailsResponseModel)
    func registerXibs()
}

class TVShowDetailsVC: UIViewController {
    
    @IBOutlet weak var tvShowTitleLbl: UILabel!
    @IBOutlet weak var tvShowForegroundImg: UIImageView!
    @IBOutlet weak var tvShowRatingLbl: UILabel!
    @IBOutlet weak var tvShowsEpisodesLbl: UILabel!
    @IBOutlet weak var tvShowsReleaseDateLbl: UILabel!
    @IBOutlet weak var tvShowOverviewLbl: UILabel!
    @IBOutlet weak var tvShowsSeasonsTBLViewOutlet: UITableView!
    @IBOutlet weak var tvShowActorsCollectionViewOutlet: UICollectionView!
    
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
    
    func registerXibs(){
        let ActorsCollectionViewCellNib = UINib(nibName: "ActorsCollectionViewCell", bundle: nil)
        tvShowActorsCollectionViewOutlet.register(ActorsCollectionViewCellNib, forCellWithReuseIdentifier: "ActorsCollectionViewCell")
        setupFlowLayoutForTVShowActorsCollectionViewOutlet()
    }
    
    func setupFlowLayoutForTVShowActorsCollectionViewOutlet() {
        let flowLayout = UICollectionViewFlowLayout()
        let width = (tvShowActorsCollectionViewOutlet.bounds.width / 2)
        let height = (tvShowActorsCollectionViewOutlet.bounds.height / 2) - 5
        flowLayout.itemSize = CGSize(width: width, height: height)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        tvShowActorsCollectionViewOutlet.collectionViewLayout = flowLayout
    }
    
    
    func updateUI(tvShowDetails: TVShowDetailsResponseModel){
        tvShowTitleLbl.text = tvShowDetails.name
        let tvShowForegroundImgUrl = "https://image.tmdb.org/t/p/w500\(tvShowDetails.posterPath ?? "")"
        tvShowForegroundImg.loadImage(urlString: tvShowForegroundImgUrl, placeholder: "frame.fill")
        let tvShowRating = String(format: "%.1f",tvShowDetails.voteAverage ?? 0.0)
        tvShowRatingLbl.text = tvShowRating
        tvShowsEpisodesLbl.text = "\(tvShowDetails.numberOfEpisodes ?? 0)"
        tvShowsReleaseDateLbl.text = tvShowDetails.firstAirDate?.extractYearFromDateString() ?? ""
        tvShowOverviewLbl.text = tvShowDetails.overview ?? ""
        tvShowsSeasonsTBLViewOutlet.reloadData()
        tvShowActorsCollectionViewOutlet.reloadData()
    }
    
}

extension TVShowDetailsVC: UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.tvShowDetails?.seasons?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TVShowSeasonsCell", for: indexPath) as! TVShowSeasonsCell
        guard let cellData = presenter?.tvShowDetails?.seasons?[indexPath.row],
              let defaultPosterPath = presenter?.tvShow?.posterPath else {
                  return UITableViewCell()
              }
        cell.configure(season: cellData, defaultPosterPath: defaultPosterPath)
        return cell
    }
    
}

extension TVShowDetailsVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.tvShowCast?.cast?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActorsCollectionViewCell", for: indexPath) as! ActorsCollectionViewCell
        guard let cellData = presenter?.tvShowCast?.cast?[indexPath.row] else {
            return UICollectionViewCell()
        }
        cell.configure(tvShowCast: cellData)
        return cell
    }
    
}

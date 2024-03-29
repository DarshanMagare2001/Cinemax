//
//  TVShowDetailsVC.swift
//  Cinemax
//
//  Created by IPS-161 on 27/03/24.
//

import UIKit
import YouTubePlayer

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
    @IBOutlet weak var tvShowTrailerPlayerView: YouTubePlayerView!
    @IBOutlet weak var similarTVShowsCollectionViewOutlet: UICollectionView!
    
    var presenter: TVShowDetailsVCPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidload()
    }
    
    
    @IBAction func playPauseAndStopBtnPressed(_ sender: UIButton) {
        manageVideoState(tag:sender.tag)
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
        let width = (tvShowActorsCollectionViewOutlet.bounds.width / 2) - 5
        let height = (tvShowActorsCollectionViewOutlet.bounds.height / 2) - 5
        flowLayout.itemSize = CGSize(width: width, height: height)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 0
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
        if let tvShowOverview = tvShowDetails.overview {
            tvShowOverviewLbl.text = (tvShowOverview.isEmpty ? "Overview Not Available." : tvShowOverview)
        }
        tvShowsSeasonsTBLViewOutlet.reloadData()
        tvShowActorsCollectionViewOutlet.reloadData()
        similarTVShowsCollectionViewOutlet.reloadData()
        setupTVShowTrailer()
    }
    
    func setupTVShowTrailer(){
        if let tvShowTrailer = presenter?.tvShowTrailer,
           let results = tvShowTrailer.results,
           !results.isEmpty,
           let trailerKey = results[0].key {
            if let tvShowTrailerUrl = URL(string: "https://www.youtube.com/watch?v=\(trailerKey)") {
                DispatchQueue.main.async { [weak self] in
                    self?.tvShowTrailerPlayerView.loadVideoURL(tvShowTrailerUrl)
                }
            }
        }else{
            if let tvShowTrailerUrl = URL(string: "https://www.youtube.com/watch?v=") {
                DispatchQueue.main.async { [weak self] in
                    self?.tvShowTrailerPlayerView.loadVideoURL(tvShowTrailerUrl)
                }
            }
        }
    }
    
    private func manageVideoState(tag:Int){
        if tag == 0 {
            tvShowTrailerPlayerView.play()
        }else if tag == 1 {
            tvShowTrailerPlayerView.pause()
        }else if tag == 2 {
            tvShowTrailerPlayerView.stop()
        }
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
        switch collectionView {
        case tvShowActorsCollectionViewOutlet:
            return presenter?.tvShowCast?.cast?.count ?? 0
        case similarTVShowsCollectionViewOutlet:
            return presenter?.tvShowSimilar?.results?.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case tvShowActorsCollectionViewOutlet:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActorsCollectionViewCell", for: indexPath) as! ActorsCollectionViewCell
            guard let cellData = presenter?.tvShowCast?.cast?[indexPath.row] else {
                return UICollectionViewCell()
            }
            cell.configure(tvShowCast: cellData)
            return cell
        case similarTVShowsCollectionViewOutlet:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TVShowSimilarCollectionCell", for: indexPath) as! TVShowSimilarCollectionCell
            guard let cellData = presenter?.tvShowSimilar?.results?[indexPath.row] else {
                return UICollectionViewCell()
            }
            cell.configure(tvShow: cellData)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case tvShowActorsCollectionViewOutlet:
            print("")
        case similarTVShowsCollectionViewOutlet:
            let cellData = presenter?.tvShowSimilar?.results?[indexPath.row]
            presenter?.gotoTVShowDetailsVC(tvShow:cellData)
        default:
            print("")
        }
    }
    
}

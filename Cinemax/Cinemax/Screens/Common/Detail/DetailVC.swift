//
//  DetailVC.swift
//  Cinemax
//
//  Created by IPS-161 on 14/03/24.
//

import UIKit
import YouTubePlayer
import RxSwift
import RxCocoa

protocol DetailVCProtocol : AnyObject {
    func updateUI(movieDetail:MovieDetailsModel)
    func registerXibs()
    func updateSimilarMoviesCollectionviewOutlet()
}

class DetailVC: UIViewController {
    
    @IBOutlet weak var movieBackgroundImg: UIImageView!
    @IBOutlet weak var movieForegroundImg: UIImageView!
    @IBOutlet weak var movieReleasedateLbl: UILabel!
    @IBOutlet weak var movieDurationLbl: UILabel!
    @IBOutlet weak var movieGenereLbl: UILabel!
    @IBOutlet weak var movieRatingLbl: UILabel!
    @IBOutlet weak var movieOverviewlbl: UILabel!
    @IBOutlet weak var similarMoviesCollectionviewOutlet: UICollectionView!
    @IBOutlet weak var similarMoviesCollectionViewsOtletView: RoundedCornerView!
    @IBOutlet weak var productionHouseCollectionViewOutlet: UICollectionView!
    @IBOutlet weak var movieStatus: UILabel!
    @IBOutlet weak var productionHouseCollectionViewOutletView: RoundedCornerView!
    @IBOutlet weak var movieTrailerView: YouTubePlayerView!
    @IBOutlet weak var currentTimeShowLbl: UILabel!
    @IBOutlet weak var totalTimeShowLbl: UILabel!
    @IBOutlet weak var videoProgressSlider: UISlider!
    
    var presenter : DetailVCPresenterProtocol?
    var videoDurationPublisher = BehaviorSubject<Double>(value: 00.00)
    var timer: Timer?
    let interval: TimeInterval = 0.1
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidload()
        productionHouseCollectionViewOutletView.isHidden = true
        playMovieTrailer()
    }
    
    @IBAction func seeAllBtnPressed(_ sender: UIButton) {
        if let movieData = presenter?.movieData{
            presenter?.gotoSeeAllVC(page: 1, searchText: "", movieId: movieData.id, seeAllVCInputs: SeeAllVCInputs.fetchMovieSimilar)
        }
    }
    
    @IBAction func seeMoreBtnPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func playBtnPressed(_ sender: UIButton) {
        startUpdatingCurrentTime()
        movieTrailerView.play()
        movieTrailerView.getDuration { durationInSeconds in
            if let durationInSeconds = durationInSeconds {
                DispatchQueue.main.async {
                    self.totalTimeShowLbl.toMins(duration: (durationInSeconds - 1.0))
                }
            }
        }
    }
    
    @IBAction func pauseBtnPressed(_ sender: UIButton) {
        stopUpdatingCurrentTime()
        movieTrailerView.pause()
    }
    
    @IBAction func stopBtnPressed(_ sender: UIButton) {
        movieTrailerView.stop()
        stopUpdatingCurrentTime()
    }
    
}

extension DetailVC : DetailVCProtocol {
    
    func backBtnPressed(){
        navigationController?.popViewController(animated: true)
    }
    
    func updateUI(movieDetail:MovieDetailsModel){
        similarMoviesCollectionViewsOtletView.isHidden = true
        if let productionHouseCollectionViewData = presenter?.movieProductionHouses, !(productionHouseCollectionViewData.isEmpty){
            productionHouseCollectionViewOutletView.isHidden = false
        }
        productionHouseCollectionViewOutlet.reloadData()
        let movieBackgroundImgUrl = "https://image.tmdb.org/t/p/w500\(movieDetail.posterPath ?? "")"
        movieBackgroundImg.loadImage(urlString: movieBackgroundImgUrl, placeholder: "frame.fill")
        movieForegroundImg.loadImage(urlString: movieBackgroundImgUrl, placeholder: "frame.fill")
        if let releaseDate = movieDetail.releaseDate,
           let duration = movieDetail.runtime,
           let genere = movieDetail.genres?[0],
           let rating = movieDetail.voteAverage,
           let overView = movieDetail.overview,
           let status = movieDetail.status{
            movieReleasedateLbl.text = "\(releaseDate)"
            movieDurationLbl.text = "\(duration) mins"
            movieGenereLbl.text = "\(genere.name ?? "")"
            let movieRating = String(format: "%.1f",rating)
            movieRatingLbl.text = movieRating
            movieOverviewlbl.text = overView
            movieStatus.text = "Satus:- \(status)"
        }
    }
    
    func registerXibs(){
        similarMoviesCollectionviewOutlet.delegate = self
        similarMoviesCollectionviewOutlet.dataSource = self
        let nib = UINib(nibName: "MoviesCollectionViewCell", bundle: nil)
        similarMoviesCollectionviewOutlet.register(nib, forCellWithReuseIdentifier: "MoviesCollectionViewCell")
    }
    
    func updateSimilarMoviesCollectionviewOutlet(){
        similarMoviesCollectionviewOutlet.reloadData()
        if let result = presenter?.similarMovies?.results, !result.isEmpty {
            similarMoviesCollectionViewsOtletView.isHidden = false
        }
    }
    
    func playMovieTrailer(){
        if let myVideoURL = URL(string: "https://www.youtube.com/watch?v=_inKs4eeHiI"){
            movieTrailerView.loadVideoURL(myVideoURL)
            updateDuration()
        }
    }
    
    func startUpdatingCurrentTime() {
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
            self?.updateCurrentTime()
        }
    }
    
    func updateCurrentTime() {
        movieTrailerView.getCurrentTime { [weak self] durationInSeconds in
            if let durationInSeconds = durationInSeconds {
                DispatchQueue.main.async {
                    self?.currentTimeShowLbl.toMins(duration: durationInSeconds)
                    self?.videoProgressSlider.value = Float(durationInSeconds)
                }
            }
        }
    }
    
    func updateDuration(){
        videoDurationPublisher.subscribe(onNext: { [weak self] duration in
            self?.currentTimeShowLbl.toMins(duration:duration)
            self?.videoProgressSlider.value = Float(duration)
        }).disposed(by: disposeBag)
    }
    
    func stopUpdatingCurrentTime(){
        timer?.invalidate()
        timer = nil
    }
    
}

extension  DetailVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case similarMoviesCollectionviewOutlet:
            return presenter?.similarMovies?.results?.count ?? 0
        case productionHouseCollectionViewOutlet:
            return presenter?.movieProductionHouses.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case similarMoviesCollectionviewOutlet:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewCell", for: indexPath) as!
            MoviesCollectionViewCell
            guard let cellData = presenter?.similarMovies?.results?[indexPath.row] else {
                return UICollectionViewCell()
            }
            cell.configure(movie: cellData)
            return cell
        case productionHouseCollectionViewOutlet:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductionHouseCollectionViewCell", for: indexPath) as! ProductionHouseCollectionViewCell
            guard let cellData = presenter?.movieProductionHouses[indexPath.row] else {
                return UICollectionViewCell()
            }
            cell.configure(productionCompany: cellData)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case similarMoviesCollectionviewOutlet:
            if let movieData = presenter?.similarMovies?.results?[indexPath.row]{
                presenter?.gotoDetailVC(movieData: movieData)
            }
        case productionHouseCollectionViewOutlet:
            print("Production House Tapped")
        default:
            print("Nothing")
        }
    }
    
}

private extension UILabel {
    func toMins(duration: Double){
        let totalMinutes = Int(duration) / 60
        let totalSeconds = Int(duration) % 60
        let totalTimeString = String(format: "%02d:%02d", totalMinutes, totalSeconds)
        self.text = totalTimeString
    }
}

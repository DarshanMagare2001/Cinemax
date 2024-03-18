//
//  DetailVC.swift
//  Cinemax
//
//  Created by IPS-161 on 14/03/24.
//

import UIKit

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
    var presenter : DetailVCPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidload()
    }
    
    func backBtnPressed(){
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func seeAllBtnPressed(_ sender: UIButton) {
        
    }
    
    
}

extension DetailVC : DetailVCProtocol {
    
    func updateUI(movieDetail:MovieDetailsModel){
        similarMoviesCollectionViewsOtletView.isHidden = true
        let movieBackgroundImgUrl = "https://image.tmdb.org/t/p/w500\(movieDetail.posterPath ?? "")"
        movieBackgroundImg.loadImage(urlString: movieBackgroundImgUrl, placeholder: "frame.fill")
        movieForegroundImg.loadImage(urlString: movieBackgroundImgUrl, placeholder: "frame.fill")
        if let releaseDate = movieDetail.releaseDate,
           let duration = movieDetail.runtime,
           let genere = movieDetail.genres?[0],
           let rating = movieDetail.voteAverage,
           let overView = movieDetail.overview {
            movieReleasedateLbl.text = "\(releaseDate)"
            movieDurationLbl.text = "\(duration) mins"
            movieGenereLbl.text = "\(genere.name ?? "")"
            let movieRating = String(format: "%.1f",rating)
            movieRatingLbl.text = movieRating
            movieOverviewlbl.text = overView
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
        if let similarMoviesdata = presenter?.similarMovies,
           let result = similarMoviesdata.results,
           (similarMoviesdata != nil && !result.isEmpty){
            similarMoviesCollectionViewsOtletView.isHidden = false
        }
    }
    
}

extension  DetailVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.similarMovies?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewCell", for: indexPath) as!
        MoviesCollectionViewCell
        guard let cellData = presenter?.similarMovies?.results?[indexPath.row] else {
            return UICollectionViewCell()
        }
        cell.configure(movie: cellData)
        return cell
    }
}


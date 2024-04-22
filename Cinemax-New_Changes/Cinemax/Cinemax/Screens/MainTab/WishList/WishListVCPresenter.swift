//
//  WishListVCPresenter.swift
//  Cinemax
//
//  Created by IPS-161 on 04/04/24.
//

import Foundation
import RxSwift

protocol WishListVCPresenterProtocol {
    func viewDidload()
    func fetchMoviesFromWishlist()
    var datasource : [MoviesCollectionViewDetailCellModel] { get set }
}

class WishListVCPresenter {
    weak var view: WishListVCProtocol?
    var interactor: WishListVCInteractorProtocol
    var router: WishListVCRouterProtocol
    var realmDataRepositoryManager : RealmDataRepositoryManagerProtocol?
    var datasource = [MoviesCollectionViewDetailCellModel](){
        didSet{
            DispatchQueue.main.async { [weak self] in
                self?.view?.updateUI()
            }
        }
    }
    let dispatchGroup = DispatchGroup()
    let disposeBag = DisposeBag()
    init(view: WishListVCProtocol?,interactor: WishListVCInteractorProtocol,router: WishListVCRouterProtocol,realmDataRepositoryManager : RealmDataRepositoryManagerProtocol){
        self.view = view
        self.interactor = interactor
        self.router = router
        self.realmDataRepositoryManager = realmDataRepositoryManager
    }
}

extension WishListVCPresenter: WishListVCPresenterProtocol {
    
    func viewDidload(){
        view?.registerXibs()
        view?.setupFlowlayout()
        fetchMoviesFromWishlist()
    }
    
    func fetchMoviesFromWishlist(){
        var masterMovieModelResult = [MasterMovieModelResult]()
        if let movies = realmDataRepositoryManager?.getMovieFromWishlist() {
            for movie in movies {
                if let id = movie.movieId.value { // Accessing the value property
                    let MasterMovieModelResult = MasterMovieModelResult(adult: nil, backdropPath: nil, genreIDS: nil, id: id, originalLanguage: nil, originalTitle: nil, overview: nil, popularity: nil, posterPath: nil, releaseDate: nil, title: nil, name: nil, video: nil, voteAverage: nil, voteCount: nil)
                    masterMovieModelResult.append(MasterMovieModelResult)
                }
            }
        }
        self.fetchAllMoviesPagewise(wishliastMovies:masterMovieModelResult)
    }
    
    private func fetchAllMoviesPagewise(wishliastMovies:[MasterMovieModelResult]){
        interactor.fetchAllMoviesPagewiseInDetail(movies:wishliastMovies)
            .subscribe({ data in
                switch data {
                case.success(let moviesData):
                    self.datasource = self.processMoviesDataForCell2(moviesDatasourceIndetail:moviesData)
                case.failure(let error):
                    print(error)
                }
            }).disposed(by: disposeBag)
    }
    
    private func processMoviesDataForCell2(moviesDatasourceIndetail:[MovieDetailsModel]) -> [MoviesCollectionViewDetailCellModel] {
        var tempArray = [MoviesCollectionViewDetailCellModel]()
        for shows in moviesDatasourceIndetail {
            let movieImgUrl = shows.posterPath ?? ""
            let movieNameLblText = shows.title ?? ""
            let movieReleaseDateText = shows.releaseDate ?? ""
            let movieDurationText = shows.runtime ?? 0
            let genres = shows.genres ?? []
            let movieGenereLblText = ((genres.isEmpty) ? "" : genres[0].name ?? "" )
            let movieLanguageLblText = shows.originalLanguage ?? ""
            let movieOverviewLblText = shows.overview ?? ""
            let movieRatingLblText = shows.voteAverage ?? 0.0
            let cellData = MoviesCollectionViewDetailCellModel(movieId: 0, movieImgUrl: movieImgUrl, movieNameLblText: movieNameLblText, movieReleaseDateText: movieReleaseDateText, movieDurationText: "\(movieDurationText)", movieGenereLblText: movieGenereLblText, movieLanguageLblText: movieLanguageLblText, movieOverviewLblText: movieOverviewLblText, movieRatingLblText: movieRatingLblText)
            tempArray.append(cellData)
        }
        return tempArray
    }
    
}

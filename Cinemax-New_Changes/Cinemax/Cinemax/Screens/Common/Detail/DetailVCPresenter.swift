//
//  DetailVCPresenter.swift
//  Cinemax
//
//  Created by IPS-161 on 15/03/24.
//

import Foundation
import RxSwift

protocol DetailVCPresenterProtocol {
    func viewDidload()
    func gotoDetailVC(movieId: Int?)
    func gotoSeeAllVC(page: Int?,searchText: String?,movieId: Int?,seeAllVCInputs: SeeAllVCInputs?)
    func addMovieToWishlist()
    func removeMovieFromWishlist()
    var movieId : Int? { get set }
    var movieDetail : MovieDetailsModel? { get set }
    var similarMovies : MovieResultModel? { get set }
    var movieVideos : MovieVideosResponseModel? { get set }
    var movieProductionHouses : [ProductionCompany] { get set }
    var wishlistMoviesIds : [Int] { get set }
}

class DetailVCPresenter {
    weak var view : DetailVCProtocol?
    var interactor : DetailVCInteractorProtocol
    var router: DetailVCRouterProtocol
    var movieId : Int?
    var movieDetail : MovieDetailsModel?
    var similarMovies : MovieResultModel?
    var movieVideos : MovieVideosResponseModel? {
        didSet{
            DispatchQueue.main.async { [weak self] in
                self?.view?.playMovieTrailer()
            }
        }
    }
    var movieProductionHouses = [ProductionCompany]()
    var realmDataRepositoryManager : RealmDataRepositoryManagerProtocol?
    var wishlistMoviesIds = [Int]()
    let dispatchGroup = DispatchGroup()
    let disposeBag = DisposeBag()
    init(view : DetailVCProtocol,interactor:DetailVCInteractorProtocol,router:DetailVCRouterProtocol,movieId: Int?,realmDataRepositoryManager : RealmDataRepositoryManagerProtocol?){
        self.view = view
        self.interactor = interactor
        self.movieId = movieId
        self.router = router
        self.realmDataRepositoryManager = realmDataRepositoryManager
    }
}

extension DetailVCPresenter : DetailVCPresenterProtocol {
    
    func viewDidload(){
        view?.registerXibs()
        view?.setupFlowlayout()
        fetchWishlistMoviesIds()
        loadDatasource()
    }
    
    func loadDatasource(){
        dispatchGroup.enter()
        fetchMovieData{ [weak self] in
            self?.dispatchGroup.leave()
        }
        dispatchGroup.enter()
        fetchSimilarMovies{ [weak self] in
            self?.dispatchGroup.leave()
        }
        dispatchGroup.enter()
        fetchMovieVideos{ [weak self] in
            self?.dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.view?.updateSimilarMoviesCollectionviewOutlet()
        }
    }
    
    func fetchMovieData(completionHandler:@escaping()->()){
        if let movieId = self.movieId{
            interactor.fetchMovieDetail(movieId: movieId)
                .subscribe({ response in
                    switch response {
                    case.success(let movieData):
                        print(movieData)
                        self.movieDetail = movieData
                        self.movieProductionHouses = movieData.productionCompanies?.compactMap { $0.logoPath != nil ? $0 : nil } ?? []
                        DispatchQueue.main.async { [weak self] in
                            self?.view?.updateUI(movieDetail: movieData)
                        }
                    case.failure(let error):
                        print(error)
                    }
                    completionHandler()
                }).disposed(by: disposeBag)
        }
    }
    
    func fetchSimilarMovies(completionHandler:@escaping()->()){
        if let movieId = self.movieId{
            interactor.fetchMovieSimilar(movieId: movieId, page: 1)
                .subscribe({ response in
                    switch response {
                    case.success(let movieData):
                        print(movieData)
                        self.similarMovies = movieData
                    case.failure(let error):
                        print(error)
                    }
                    completionHandler()
                }).disposed(by: disposeBag)
        }
    }
    
    func fetchMovieVideos(completionHandler:@escaping()->()){
        if let movieId = self.movieId{
            interactor.fetchMovieVideos(movieId: movieId)
                .subscribe({ response in
                    switch response {
                    case.success(let movieData):
                        print(movieData)
                        self.movieVideos = movieData
                    case.failure(let error):
                        print(error)
                    }
                    completionHandler()
                }).disposed(by: disposeBag)
        }
    }
    
    func gotoDetailVC(movieId: Int?){
        router.gotoDetailVC(movieId: movieId)
    }
    
    func gotoSeeAllVC(page: Int?,searchText: String?,movieId: Int?,seeAllVCInputs: SeeAllVCInputs?){
        router.gotoSeeAllVC(page: page, searchText: searchText, movieId: movieId, seeAllVCInputs: seeAllVCInputs)
    }
    
    func addMovieToWishlist(){
        if let movieId = self.movieId{
            let movie = RealmMoviesModel(movieId: movieId)
            realmDataRepositoryManager?.addMovieToWishlist(movie:movie)
            fetchWishlistMoviesIds()
        }
    }
    
    func removeMovieFromWishlist(){
        if let movieId = self.movieId{
            realmDataRepositoryManager?.deleteMovieFromWishlist(movieId:movieId)
            fetchWishlistMoviesIds()
        }
    }
    
    func fetchWishlistMoviesIds(){
        var tempArray = [Int]()
        if let wishlistMoviesArray = realmDataRepositoryManager?.getMovieFromWishlist() {
            for movie in wishlistMoviesArray {
                if let movieId = movie.movieId.value {
                    tempArray.append(movieId)
                }
            }
            wishlistMoviesIds = tempArray
        }
    }
    
}

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
    func gotoDetailVC(movieData: MasterMovieModelResult?)
    func gotoSeeAllVC(page: Int?,searchText: String?,movieId: Int?,seeAllVCInputs: SeeAllVCInputs?)
    var movieData : MasterMovieModelResult? { get set }
    var similarMovies : MovieResultModel? { get set }
    var movieVideos : MovieVideosResponseModel? { get set }
    var movieProductionHouses : [ProductionCompany] { get set }
}

class DetailVCPresenter {
    weak var view : DetailVCProtocol?
    var interactor : DetailVCInteractorProtocol
    var router: DetailVCRouterProtocol
    var movieData : MasterMovieModelResult?
    var similarMovies : MovieResultModel?
    var movieVideos : MovieVideosResponseModel? {
        didSet{
            DispatchQueue.main.async { [weak self] in
                self?.view?.playMovieTrailer()
            }
        }
    }
    var movieProductionHouses = [ProductionCompany]()
    let dispatchGroup = DispatchGroup()
    let disposeBag = DisposeBag()
    init(view : DetailVCProtocol,interactor:DetailVCInteractorProtocol,router:DetailVCRouterProtocol,movieData: MasterMovieModelResult?){
        self.view = view
        self.interactor = interactor
        self.movieData = movieData
        self.router = router
    }
}

extension DetailVCPresenter : DetailVCPresenterProtocol {
    
    func viewDidload(){
        view?.registerXibs()
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
        if let data = self.movieData{
            interactor.fetchMovieDetail(movieId: data.id)
                .subscribe({ response in
                    switch response {
                    case.success(let movieData):
                        print(movieData)
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
        if let data = self.movieData{
            interactor.fetchMovieSimilar(movieId: data.id, page: 1)
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
        if let data = self.movieData{
            interactor.fetchMovieVideos(movieId: data.id)
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
    
    func gotoDetailVC(movieData: MasterMovieModelResult?){
        router.gotoDetailVC(movieData: movieData)
    }
    
    func gotoSeeAllVC(page: Int?,searchText: String?,movieId: Int?,seeAllVCInputs: SeeAllVCInputs?){
        router.gotoSeeAllVC(page: page, searchText: searchText, movieId: movieId, seeAllVCInputs: seeAllVCInputs)
    }
    
}

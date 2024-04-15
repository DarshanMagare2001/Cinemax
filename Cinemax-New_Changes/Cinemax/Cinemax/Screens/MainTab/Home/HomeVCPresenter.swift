//
//  HomeVCPresenter.swift
//  Cinemax
//
//  Created by IPS-161 on 06/02/24.
//

import Foundation
import RxSwift

protocol HomeVCPresenterProtocol {
    func viewDidload()
    func viewWillAppear()
    func loadDataSource()
    func gotoDetailVC(movieData: MasterMovieModelResult?)
    func gotoSeeAllVC(page: Int?,searchText: String?,movieId: Int?,seeAllVCInputs: SeeAllVCInputs?)
    func gotoTVShowDetailsVC(tvShow: TVShowsResponseModelResult?)
    var movieUpcomingDatasource : MasterMovieModel? { get set }
    var movieNowPlayingDatasource : MasterMovieModel? { get set }
    var movieTopRatedDatasource : MasterMovieModel? { get set }
    var moviePopularDatasource : MasterMovieModel? { get set }
    var tvShowsDatasource : TVShowsResponseModel? { get set }
}

class HomeVCPresenter {
    weak var view: HomeVCProtocol?
    var interactor: HomeVCInteractorProtocol
    var router: HomeVCRouterProtocol
    var movieUpcomingDatasource : MasterMovieModel?
    var movieNowPlayingDatasource : MasterMovieModel?
    var movieTopRatedDatasource : MasterMovieModel?
    var moviePopularDatasource : MasterMovieModel?
    var tvShowsDatasource : TVShowsResponseModel?
    var dispatchGroup = DispatchGroup()
    let disposeBag = DisposeBag()
    init(view: HomeVCProtocol,interactor: HomeVCInteractorProtocol,router: HomeVCRouterProtocol){
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension HomeVCPresenter: HomeVCPresenterProtocol {
    
    func viewDidload(){
        loadDataSource()
        view?.bindUI()
        view?.registerXib()
        view?.addRefreshcontroToTableview()
    }
    
    func viewWillAppear(){
        
    }
    
    func loadDataSource(){
        
        dispatchGroup.enter()
        fetchMovieUpcoming { [weak self] in
            self?.dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        fetchMovieNowPlaying { [weak self] in
            self?.dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        fetchMovieTopRated { [weak self] in
            self?.dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        fetchMoviePopular { [weak self] in
            self?.dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        fetchTVShows { [weak self] in
            self?.dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main){ [weak self] in
            self?.view?.updateUI()
        }
    }
    
    private func fetchMovieUpcoming(completionHandler:@escaping()->()){
        interactor.fetchMovieUpcoming(page: 1)
            .subscribe({ response in
                switch response {
                case.success(let movieData):
                    self.movieUpcomingDatasource = movieData
                case.failure(let error):
                    print(error)
                }
                completionHandler()
            }).disposed(by: disposeBag)
    }
    
    private func fetchMovieNowPlaying(completionHandler:@escaping()->()){
        interactor.fetchMovieNowPlaying(page: 1)
            .subscribe({ response in
                switch response {
                case.success(let movieData):
                    self.movieNowPlayingDatasource = movieData
                case.failure(let error):
                    print(error)
                }
                completionHandler()
            }).disposed(by: disposeBag)
    }
    
    private func fetchMovieTopRated(completionHandler:@escaping()->()){
        interactor.fetchMovieTopRated(page: 1)
            .subscribe({ response in
                switch response {
                case.success(let movieData):
                    self.movieTopRatedDatasource = movieData
                case.failure(let error):
                    print(error)
                }
                completionHandler()
            }).disposed(by: disposeBag)
    }
    
    private func fetchMoviePopular(completionHandler:@escaping()->()){
        interactor.fetchMoviePopular(page: 1)
            .subscribe({ response in
                switch response {
                case.success(let movieData):
                    self.moviePopularDatasource = movieData
                case.failure(let error):
                    print(error)
                }
                completionHandler()
            }).disposed(by: disposeBag)
    }
    
    private func fetchTVShows(completionHandler:@escaping()->()){
        interactor.fetchTVShows(page: 1)
            .subscribe({ response in
                switch response {
                case.success(let showsData):
                    self.tvShowsDatasource = showsData
                case.failure(let error):
                    print(error)
                }
                completionHandler()
            }).disposed(by: disposeBag)
    }
    
    func gotoDetailVC(movieData: MasterMovieModelResult?){
        router.gotoDetailVC(movieData: movieData)
    }
    
    func gotoSeeAllVC(page: Int?,searchText: String?,movieId: Int?,seeAllVCInputs: SeeAllVCInputs?){
        router.gotoSeeAllVC(page: page, searchText: searchText, movieId: movieId, seeAllVCInputs: seeAllVCInputs)
    }
    
    func gotoTVShowDetailsVC(tvShow: TVShowsResponseModelResult?){
        router.gotoTVShowDetailsVC(tvShow: tvShow)
    }
    
}

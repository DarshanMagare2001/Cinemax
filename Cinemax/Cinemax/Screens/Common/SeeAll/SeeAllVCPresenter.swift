//
//  SeeAllVCPresenter.swift
//  Cinemax
//
//  Created by IPS-161 on 19/03/24.
//

import Foundation
import RxSwift

protocol SeeAllVCPresenterProtocol {
    func viewDidload()
    var moviesHeadline : String? { get set }
    var moviesDatasource : [MasterMovieModelResult] { get set }
    func fetchMovieDetail(movieId:Int) -> Single<MovieDetailsModel>
}

class SeeAllVCPresenter {
    weak var view: SeeAllVCProtocol?
    var interactor: SeeAllVCInteractorProtocol
    var router: SeeAllVCRouterProtocol
    var moviesHeadline : String?
    var moviesDatasource = [MasterMovieModelResult]() {
        didSet{
            DispatchQueue.main.async { [weak self] in
                self?.view?.updateCollectionView()
            }
        }
    }
    var seeAllVCInputs: SeeAllVCInputs?
    var movieId: Int?
    var searchText: String?
    var page: Int?
    let disposeBag = DisposeBag()
    init(view: SeeAllVCProtocol,interactor: SeeAllVCInteractorProtocol,router: SeeAllVCRouterProtocol){
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension SeeAllVCPresenter: SeeAllVCPresenterProtocol  {
    
    func viewDidload(){
        view?.registerXibs()
        DispatchQueue.main.async { [weak self] in
            self?.view?.updateUI()
        }
        DispatchQueue.global(qos: .userInteractive).async{ [weak self] in
            self?.loadDatasource(seeAllVCInputs: self?.seeAllVCInputs, movieId: self?.movieId, searchText: self?.searchText, page: self?.page)
        }
    }
    
    func loadDatasource(seeAllVCInputs: SeeAllVCInputs?,movieId: Int?,searchText: String?,page: Int?){
        guard let page = page , page <= 463 else {
            return
        }
        interactor.fetchAllMoviesPagewise(seeAllVCInputs: seeAllVCInputs, movieId: movieId, searchText: searchText, page: page)
            .subscribe({ data in
                switch data {
                case.success(let movieData):
                    print(movieData)
                    self.moviesDatasource.append(contentsOf: movieData)
                    self.fetchAllMoviesPagewiseInDetail(movies:movieData)
                case.failure(let error):
                    print(error)
                }
            }).disposed(by: disposeBag)
        self.page = (page + 1)
    }
    
    func fetchMovieDetail(movieId:Int) -> Single<MovieDetailsModel> {
        return interactor.fetchMovieDetail(movieId: movieId)
    }
    
    func fetchAllMoviesPagewiseInDetail(movies: [MasterMovieModelResult]){
        interactor.fetchAllMoviesPagewiseInDetail(movies:movies)
            .subscribe({ data in
                switch data {
                case.success(let movieData):
                    print(movieData)
                case.failure(let error):
                    print(error)
                }
            }).disposed(by: disposeBag)
    }
    
}


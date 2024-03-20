//
//  SeeAllVCPresenter.swift
//  Cinemax
//
//  Created by IPS-161 on 19/03/24.
//

import Foundation
import RxSwift

enum SortMovies{
    case byRating
    case byNameAZ
    case byNameZA
}

protocol SeeAllVCPresenterProtocol {
    func viewDidload()
    func loadPaginatedData()
    func sortMovies(sortBy:SortMovies)
    var moviesHeadline : String? { get set }
    var moviesDatasource : [MasterMovieModelResult] { get set }
    var moviesDatasourceIndetail : [MovieDetailsModel] { get set }
}

class SeeAllVCPresenter {
    weak var view: SeeAllVCProtocol?
    var interactor: SeeAllVCInteractorProtocol
    var router: SeeAllVCRouterProtocol
    var moviesHeadline : String?
    var moviesDatasource = [MasterMovieModelResult]()
    var moviesDatasourceIndetail = [MovieDetailsModel](){
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
        view?.setupFlowlayout()
        DispatchQueue.main.async { [weak self] in
            self?.view?.updateUI()
        }
        DispatchQueue.global(qos: .userInteractive).async{ [weak self] in
            self?.loadDatasource(seeAllVCInputs: self?.seeAllVCInputs, movieId: self?.movieId, searchText: self?.searchText, page: self?.page)
        }
    }
    
    func loadPaginatedData(){
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
    
    func fetchAllMoviesPagewiseInDetail(movies:[MasterMovieModelResult]){
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            self?.interactor.fetchAllMoviesPagewiseInDetail(movies:movies)
                .subscribe({ data in
                    switch data {
                    case.success(let movieData):
                        print(movieData)
                        self?.moviesDatasourceIndetail.append(contentsOf:movieData)
                    case.failure(let error):
                        print(error)
                    }
                }).disposed(by: self!.disposeBag)
        }
    }
    
    func sortMovies(sortBy: SortMovies) {
        switch sortBy {
        case .byRating:
            // Sort movies by voteAverage in descending order
            moviesDatasource.sort{ $0.voteAverage ?? 0 > $1.voteAverage ?? 0 }
            moviesDatasourceIndetail.sort { $0.voteAverage ?? 0 > $1.voteAverage ?? 0 }
        case .byNameAZ:
            // Sort movies by title in ascending order
            moviesDatasource.sort{ $0.title ?? "" < $1.title ?? "" }
            moviesDatasourceIndetail.sort { $0.title ?? "" < $1.title ?? "" }
        case .byNameZA:
            // Sort movies by title in descending order
            moviesDatasource.sort{ $0.title ?? "" > $1.title ?? "" }
            moviesDatasourceIndetail.sort { $0.title ?? "" > $1.title ?? "" }
        }
    }
    
}


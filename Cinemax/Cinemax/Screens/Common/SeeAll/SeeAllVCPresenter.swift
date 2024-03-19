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
    
}


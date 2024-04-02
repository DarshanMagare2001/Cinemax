//
//  SearchVCPresenter.swift
//  Cinemax
//
//  Created by IPS-161 on 01/04/24.
//

import Foundation
import RxSwift
import RxCocoa

protocol SearchVCPresenterProtocol {
    func viewDidload()
    var searchQuery: BehaviorRelay<String> { get set }
    var datasource : MasterMovieModel? { get set }
}

class SearchVCPresenter {
    weak var view: SearchVCProtocol?
    var interactor: SearchVCInteractorProtocol
    var router: SearchVCRouterProtocol
    var searchQuery = BehaviorRelay<String>(value: "")
    var datasource : MasterMovieModel? {
        didSet{
            DispatchQueue.main.async { [weak self] in
                self?.view?.updateUI()
            }
        }
    }
    let disposeBag = DisposeBag()
    init(view: SearchVCProtocol,interactor: SearchVCInteractorProtocol,router: SearchVCRouterProtocol){
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension SearchVCPresenter: SearchVCPresenterProtocol {
    
    func viewDidload(){
        loadDatasource()
    }
    
    func loadDatasource(){
        searchQuery
            .skip(1)
            .map({$0})
            .subscribe({ data in
                if let query = data.element{
                    print(query)
                    self.fetchSearchedMovies(query:query)
                }
            }).disposed(by: disposeBag)
    }
    
    private func fetchSearchedMovies(query:String){
        interactor.fetchMovieSearch(searchText: query, page: 1)
            .subscribe({ data in
                switch data {
                case.success(let movies):
                    let moviesData = MasterMovieModel(dates: nil, page: movies.page ?? 0, results: movies.results ?? [], totalPages: movies.totalPages ?? 0, totalResults: movies.totalResults ?? 0)
                    print(moviesData)
                    self.datasource = moviesData
                case.failure(let error):
                    print(error)
                }
            }).disposed(by: disposeBag)
    }
    
}

//
//  TVShowSimilarVCPresenter.swift
//  Cinemax
//
//  Created by IPS-161 on 29/03/24.
//

import Foundation
import RxSwift

protocol TVShowSimilarVCPresenterProtocol {
    func viewDidload()
    func loadDatasource()
    var similarTVShowsData: [TVShowsResponseModelResult] { get set }
}

class TVShowSimilarVCPresenter {
    weak var view: TVShowSimilarVCProtocol?
    var interactor: TVShowSimilarVCInteractorProtocol
    var router: TVShowSimilarVCRouterProtocol
    var tvShowData: TVShowsResponseModelResult?
    var similarTVShowsData = [TVShowsResponseModelResult]() {
        didSet{
            DispatchQueue.main.async { [weak self] in
                self?.view?.updateUI()
            }
        }
    }
    var page: Int?
    let disposeBag = DisposeBag()
    init(view: TVShowSimilarVCProtocol,interactor: TVShowSimilarVCInteractorProtocol,router: TVShowSimilarVCRouterProtocol){
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension TVShowSimilarVCPresenter: TVShowSimilarVCPresenterProtocol {
    
    func viewDidload(){
        loadDatasource()
    }
    
    func loadDatasource(){
        guard let page = page , page <= 500 else {
            return
        }
        if let tvShowData = tvShowData{
            DispatchQueue.global(qos: .userInteractive).async{ [weak self] in
                self?.interactor.fetchTVShowSimilar(similarId: tvShowData.id , page: page)
                    .subscribe({ data in
                        switch data {
                        case.success(let data):
                            if let results = data.results {
                                self?.similarTVShowsData.append(contentsOf: results)
                            }
                        case.failure(let error):
                            print(error)
                        }
                    }).disposed(by: self!.disposeBag)
            }
        }
        self.page = (page + 1)
    }
    
}

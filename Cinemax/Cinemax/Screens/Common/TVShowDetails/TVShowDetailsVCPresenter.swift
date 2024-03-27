//
//  TVShowDetailsVCPresenter.swift
//  Cinemax
//
//  Created by IPS-161 on 27/03/24.
//

import Foundation
import RxSwift

protocol TVShowDetailsVCPresenterProtocol {
    func viewDidload()
    var tvShow: TVShowsResponseModelResult? { get set }
}

class TVShowDetailsVCPresenter {
    weak var view: TVShowDetailsVCProtocol?
    var interactor: TVShowDetailsVCInteractorProtocol
    var router: TVShowDetailsVCRouterProtocol
    var tvShow: TVShowsResponseModelResult?
    let disposeBag = DisposeBag()
    init(view: TVShowDetailsVCProtocol,interactor: TVShowDetailsVCInteractorProtocol,router: TVShowDetailsVCRouterProtocol){
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension TVShowDetailsVCPresenter: TVShowDetailsVCPresenterProtocol {
    
    func viewDidload(){
        fetchTVShowDetails()
    }
    
    func fetchTVShowDetails(){
        if let tvShow = tvShow {
            interactor.fetchTVShowDetails(showId: tvShow.id)
                .subscribe({ response in
                    switch response {
                    case.success(let showsData):
                        print(showsData)
                    case.failure(let error):
                        print(error)
                    }
                }).disposed(by: disposeBag)
        }
    }
    
}

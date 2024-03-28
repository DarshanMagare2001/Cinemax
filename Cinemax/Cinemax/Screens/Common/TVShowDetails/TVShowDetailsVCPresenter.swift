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
    var tvShowDetails: TVShowDetailsResponseModel? { get set }
    var tvShowCast: TVShowCastResponseModel? { get set }
}

class TVShowDetailsVCPresenter {
    weak var view: TVShowDetailsVCProtocol?
    var interactor: TVShowDetailsVCInteractorProtocol
    var router: TVShowDetailsVCRouterProtocol
    var tvShow: TVShowsResponseModelResult?
    var tvShowDetails: TVShowDetailsResponseModel?
    var tvShowCast: TVShowCastResponseModel?
    let disposeBag = DisposeBag()
    let dispatchGroup = DispatchGroup()
    init(view: TVShowDetailsVCProtocol,interactor: TVShowDetailsVCInteractorProtocol,router: TVShowDetailsVCRouterProtocol){
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension TVShowDetailsVCPresenter: TVShowDetailsVCPresenterProtocol {
    
    func viewDidload(){
        view?.registerXibs()
        loadDatasource()
    }
    
    func loadDatasource(){
        dispatchGroup.enter()
        fetchTVShowDetails{
            self.dispatchGroup.leave()
        }
        dispatchGroup.enter()
        fetchTVShowCast{
            self.dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main){ [weak self] in
            if let tvShowDetails = self?.tvShowDetails {
                self?.view?.updateUI(tvShowDetails: tvShowDetails)
            }
        }
    }
    
    func fetchTVShowDetails(completion:@escaping ()->()){
        if let tvShow = tvShow {
            interactor.fetchTVShowDetails(showId: tvShow.id)
                .subscribe({ response in
                    switch response {
                    case.success(let showsData):
                        self.tvShowDetails = showsData
                    case.failure(let error):
                        print(error)
                    }
                    completion()
                }).disposed(by: disposeBag)
        }
    }
    
    func fetchTVShowCast(completion:@escaping ()->()){
        if let tvShow = tvShow {
            interactor.fetchTVShowCast(showId: tvShow.id)
                .subscribe({ response in
                    switch response {
                    case.success(let castData):
                        print(castData)
                        self.tvShowCast = castData
                    case.failure(let error):
                        print(error)
                    }
                    completion()
                }).disposed(by: disposeBag)
        }
    }
    
}

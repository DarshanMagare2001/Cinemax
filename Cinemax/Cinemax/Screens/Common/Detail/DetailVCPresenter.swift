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
}

class DetailVCPresenter {
    weak var view : DetailVCProtocol?
    var interactor : DetailVCInteractorProtocol
    var movieData : MasterMovieModelResult?
    let disposeBag = DisposeBag()
    init(view : DetailVCProtocol,interactor : DetailVCInteractorProtocol, movieData : MasterMovieModelResult?){
        self.view = view
        self.interactor = interactor
        self.movieData = movieData
    }
}

extension DetailVCPresenter : DetailVCPresenterProtocol {
    
    func viewDidload(){
        loadDatasource()
    }
    
    func loadDatasource(){
        if let data = self.movieData{
            interactor.fetchMovieDetail(movieId: data.id)
                .subscribe({ response in
                    switch response {
                    case.success(let movieData):
                        print(movieData)
                        DispatchQueue.main.async { [weak self] in
                            self?.view?.updateUI(movieDetail: movieData)
                        }
                    case.failure(let error):
                        print(error)
                    }
                }).disposed(by: disposeBag)
        }
    }
    
}

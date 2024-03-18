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
    var similarMovies : MovieResultModel? { get set }
}

class DetailVCPresenter {
    weak var view : DetailVCProtocol?
    var interactor : DetailVCInteractorProtocol
    var movieData : MasterMovieModelResult?
    var similarMovies : MovieResultModel?
    let dispatchGroup = DispatchGroup()
    let disposeBag = DisposeBag()
    init(view : DetailVCProtocol,interactor : DetailVCInteractorProtocol, movieData : MasterMovieModelResult?){
        self.view = view
        self.interactor = interactor
        self.movieData = movieData
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
    
}

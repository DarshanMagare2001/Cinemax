//
//  DetailVCPresenter.swift
//  Cinemax
//
//  Created by IPS-161 on 15/03/24.
//

import Foundation

protocol DetailVCPresenterProtocol {
    func viewDidload()
}

class DetailVCPresenter {
    weak var view : DetailVCProtocol?
    var interactor : DetailVCInteractorProtocol
    var movieData : MasterMovieModelResult?
    init(view : DetailVCProtocol,interactor : DetailVCInteractorProtocol, movieData : MasterMovieModelResult?){
        self.view = view
        self.interactor = interactor
        self.movieData = movieData
    }
}

extension DetailVCPresenter : DetailVCPresenterProtocol {
    func viewDidload(){
        DispatchQueue.main.async {
            if let data = self.movieData{
                let movieimgUrl = "https://image.tmdb.org/t/p/w500\(data.posterPath)"
                self.view?.updateUI(movieImgUrl:movieimgUrl)
            }
        }
    }
}

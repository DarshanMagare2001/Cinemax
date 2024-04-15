//
//  WishListVCPresenter.swift
//  Cinemax
//
//  Created by IPS-161 on 04/04/24.
//

import Foundation
import RxSwift

protocol WishListVCPresenterProtocol {
    func viewDidload()
    func fetchMoviesFromWishlist()
}

class WishListVCPresenter {
    weak var view: WishListVCProtocol?
    var interactor: WishListVCInteractorProtocol
    var router: WishListVCRouterProtocol
    let dispatchGroup = DispatchGroup()
    let disposeBag = DisposeBag()
    init(view: WishListVCProtocol?,interactor: WishListVCInteractorProtocol,router: WishListVCRouterProtocol){
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension WishListVCPresenter: WishListVCPresenterProtocol {
    
    func viewDidload(){
        fetchMoviesFromWishlist()
    }
    
    func fetchMoviesFromWishlist(){
        interactor.fetchMoviesFromWishlist { data in
            switch data {
            case.success(let wishlistMoviesData):
                self.fetchAllMoviesPagewise(wishliastMovies:wishlistMoviesData)
            case.failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchAllMoviesPagewise(wishliastMovies:[CDMoviesModel]){
        var movies = [MasterMovieModelResult]()
        for element in wishliastMovies{
            if let id = element.id{
                let MasterMovieModelResult = MasterMovieModelResult(adult: nil, backdropPath: nil, genreIDS: nil, id: id, originalLanguage: nil, originalTitle: nil, overview: nil, popularity: nil, posterPath: nil, releaseDate: nil, title: nil, name: nil, video: nil, voteAverage: nil, voteCount: nil)
                movies.append(MasterMovieModelResult)
            }
        }
        interactor.fetchAllMoviesPagewiseInDetail(movies:movies)
            .subscribe({ data in
                switch data {
                case.success(let moviesData):
                    print(moviesData)
                case.failure(let error):
                    print(error)
                }
            }).disposed(by: disposeBag)
    }
    
}

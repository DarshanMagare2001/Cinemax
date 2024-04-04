//
//  GenresVCPresenter.swift
//  Cinemax
//
//  Created by IPS-161 on 03/04/24.
//

import Foundation

protocol GenresVCPresenterProtocol {
    func viewDidload()
    func gotoSeeAllVC(genreId: Int?, page: Int?, searchText: String?, movieId: Int?, seeAllVCInputs: SeeAllVCInputs?)
    var genresDatasource : [GenresVCEntity] { get set }
}

class GenresVCPresenter {
    weak var view: GenresVCProtocol?
    var interactor: GenresVCInteractorProtocol
    var router: GenresVCRouterProtocol
    var genresDatasource = [GenresVCEntity](){
        didSet{
            DispatchQueue.main.async { [weak self] in
                self?.view?.updateUI()
            }
        }
    }
    init(view: GenresVCProtocol,interactor: GenresVCInteractorProtocol,router: GenresVCRouterProtocol){
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension GenresVCPresenter: GenresVCPresenterProtocol {
    
    func viewDidload(){
        setupDatasource()
    }
    
    func setupDatasource(){
        let datasource = [GenresVCEntity(genresName: "Action", genresId: " 28"),GenresVCEntity(genresName: "Adventure", genresId: "12"),GenresVCEntity(genresName: "Animation", genresId: "16"),GenresVCEntity(genresName: "Comedy", genresId: "35"),GenresVCEntity(genresName: "Crime", genresId: "80"),GenresVCEntity(genresName: "Documentary", genresId: "99"),GenresVCEntity(genresName: "Drama", genresId: "18"),GenresVCEntity(genresName: "Family", genresId: "10751"),GenresVCEntity(genresName: "Fantasy", genresId: "14"),GenresVCEntity(genresName: "History", genresId: "36"),GenresVCEntity(genresName: "Horror", genresId: "27"),GenresVCEntity(genresName: "Music", genresId: "10402"),GenresVCEntity(genresName: "Mystery", genresId: "9648"),GenresVCEntity(genresName: "Romance", genresId: "10749"),GenresVCEntity(genresName: "Science Fiction", genresId: "878"),GenresVCEntity(genresName: "Thriller", genresId: "53"),GenresVCEntity(genresName: "War", genresId: "10752"),GenresVCEntity(genresName: "Western", genresId: "37")]
        self.genresDatasource = datasource
    }
    
    func gotoSeeAllVC(genreId: Int?, page: Int?, searchText: String?, movieId: Int?, seeAllVCInputs: SeeAllVCInputs?){
        router.gotoSeeAllVC(genreId: genreId, page: page, searchText: searchText, movieId: movieId, seeAllVCInputs: seeAllVCInputs)
    }
    
}

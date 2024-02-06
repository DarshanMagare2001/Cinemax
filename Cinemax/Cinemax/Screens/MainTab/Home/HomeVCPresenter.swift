//
//  HomeVCPresenter.swift
//  Cinemax
//
//  Created by IPS-161 on 06/02/24.
//

import Foundation

protocol HomeVCPresenterProtocol {
    func viewDidload()
    func viewWillAppear()
    var upcomingMovies:[MasterMoviesModel] { get set }
    var nowplayingMovies:[MasterMoviesModel] { get set }
    var trendingMovies:[MasterMoviesModel] { get set }
    var boxofficeMovies:[MasterMoviesModel] { get set }
}

class HomeVCPresenter {
    weak var view: HomeVCProtocol?
    var interactor: HomeVCInteractorProtocol
    var router: HomeVCRouterProtocol
    var upcomingMovies = [MasterMoviesModel]()
    var nowplayingMovies = [MasterMoviesModel]()
    var trendingMovies = [MasterMoviesModel]()
    var boxofficeMovies = [MasterMoviesModel]()
    var dispatchGroup = DispatchGroup()
    init(view: HomeVCProtocol,interactor: HomeVCInteractorProtocol,router: HomeVCRouterProtocol){
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension HomeVCPresenter: HomeVCPresenterProtocol {
    
    func viewDidload(){
        loadDataSource()
    }
    
    func viewWillAppear(){
        setupUI()
    }
    
    
    private func setupUI(){
        if let name = UserdefaultRepositoryManager.fetchUserInfoFromUserdefault(type: .currentUsersName),
           let profileImgUrl = UserdefaultRepositoryManager.fetchUserInfoFromUserdefault(type: .currentUsersProfileImageUrl){
            DispatchQueue.main.async { [weak self] in
                self?.view?.setupUI(name: name, profileImgUrl: profileImgUrl)
            }
        }
    }
    
    func loadDataSource(){
        
        dispatchGroup.enter()
        fetchUpcomingMoviesData { [weak self] in
            self?.dispatchGroup.leave()
        }
        dispatchGroup.enter()
        fetchNowplayingMoviesData { [weak self] in
            self?.dispatchGroup.leave()
        }
        dispatchGroup.enter()
        fetchTrendingMoviesData { [weak self] in
            self?.dispatchGroup.leave()
        }
        dispatchGroup.enter()
        fetchBoxofficeMoviesData { [weak self] in
            self?.dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main){ [weak self] in
            DispatchQueue.main.async { [weak self] in
                self?.view?.updateUI()
            }
        }
        
    }
    
    func fetchUpcomingMoviesData(completion:@escaping()->()){
        DispatchQueue.global(qos: .background).async{ [weak self] in
            self?.interactor.fetchUpcomingMovies(pageCount: 1) { result in
                switch result {
                case.success(let data):
                    print(data)
                    if let data = data {
                        self?.upcomingMovies = data
                    }
                    completion()
                case.failure(let error):
                    print(error)
                    completion()
                }
            }
        }
    }
    
    func fetchNowplayingMoviesData(completion:@escaping()->()){
        DispatchQueue.global(qos: .background).async{ [weak self] in
            self?.interactor.fetchUpcomingMovies(pageCount: 1) { result in
                switch result {
                case.success(let data):
                    if let data = data {
                        self?.nowplayingMovies = data
                    }
                    completion()
                case.failure(let error):
                    print(error)
                    completion()
                }
            }
        }
    }
    
    func fetchTrendingMoviesData(completion:@escaping()->()){
        DispatchQueue.global(qos: .background).async{ [weak self] in
            self?.interactor.fetchUpcomingMovies(pageCount: 1) { result in
                switch result {
                case.success(let data):
                    if let data = data {
                        self?.trendingMovies = data
                    }
                    completion()
                case.failure(let error):
                    print(error)
                    completion()
                }
            }
        }
    }
    
    func fetchBoxofficeMoviesData(completion:@escaping()->()){
        DispatchQueue.global(qos: .background).async{ [weak self] in
            self?.interactor.fetchUpcomingMovies(pageCount: 1) { result in
                switch result {
                case.success(let data):
                    if let data = data {
                        self?.boxofficeMovies = data
                    }
                    completion()
                case.failure(let error):
                    print(error)
                    completion()
                }
            }
        }
    }
    
}

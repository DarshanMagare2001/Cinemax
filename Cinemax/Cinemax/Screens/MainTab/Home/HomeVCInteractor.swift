import Foundation

protocol HomeVCInteractorProtocol {
    func fetchUpcomingMovies(pageCount: Int,completion:@escaping(Result<[MasterMoviesModel]?,Error>)->())
}

class HomeVCInteractor {
    var moviesServiceManager : MoviesServiceManagerProtocol?
    init(moviesServiceManager : MoviesServiceManagerProtocol){
        self.moviesServiceManager = moviesServiceManager
    }
}

extension HomeVCInteractor: HomeVCInteractorProtocol {
    
    func fetchUpcomingMovies(pageCount: Int,completion:@escaping(Result<[MasterMoviesModel]?,Error>)->()){
        moviesServiceManager?.fetchUpcomingMovies(pageCount: pageCount, completion: { result in
            completion(result)
        })
    }
    
}


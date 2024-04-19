//
//  RealmDataRepositoryManager.swift
//  Cinemax
//
//  Created by IPS-177  on 19/04/24.
//

import Foundation
import RealmSwift

protocol RealmDataRepositoryManagerProtocol {
    func addMovieToWishlist(movie: RealmMoviesModel)
    func getMovieFromWishlist()->[RealmMoviesModel]
}

class RealmDataRepositoryManager {
    static let shared = RealmDataRepositoryManager()
    private init(){}
}

extension RealmDataRepositoryManager: RealmDataRepositoryManagerProtocol {
    
    func addMovieToWishlist(movie: RealmMoviesModel) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(movie)
            }
        } catch {
            print(error)
        }
    }
    
    func getMovieFromWishlist()->[RealmMoviesModel] {
        var tempArray = [RealmMoviesModel]()
        do {
            let realm = try Realm()
            let results = realm.objects(RealmMoviesModel.self)
            for movies in results {
                tempArray.append(movies)
            }
        } catch {
            print(error)
        }
        return tempArray
    }
    
}

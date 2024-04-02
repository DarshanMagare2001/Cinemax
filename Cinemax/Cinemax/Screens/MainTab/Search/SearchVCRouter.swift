//
//  SearchVCRouter.swift
//  Cinemax
//
//  Created by IPS-161 on 01/04/24.
//

import Foundation
import UIKit

protocol SearchVCRouterProtocol {
    func gotoDetailVC(movieData: MasterMovieModelResult?)
    func gotoSeeAllVC(page: Int?,searchText: String?,movieId: Int?,seeAllVCInputs: SeeAllVCInputs?)
    func gotoTVShowDetailsVC(tvShow: TVShowsResponseModelResult?)
}

class SearchVCRouter {
    var viewController: UIViewController
    init(viewController: UIViewController){
        self.viewController = viewController
    }
}

extension SearchVCRouter: SearchVCRouterProtocol {
    func gotoDetailVC(movieData: MasterMovieModelResult?){
        let detailVC = DetailVCBuilder.build(movieData: movieData)
        viewController.navigationController?.pushViewController(detailVC, animated: true)
    }
    func gotoSeeAllVC(page: Int?,searchText: String?,movieId: Int?,seeAllVCInputs: SeeAllVCInputs?){
        let seeAllVC = SeeAllVCBuilder.build(page: page, searchText: searchText, movieId: movieId, seeAllVCInputs: seeAllVCInputs)
        viewController.navigationController?.pushViewController(seeAllVC, animated: true)
    }
    func gotoTVShowDetailsVC(tvShow: TVShowsResponseModelResult?){
        let tvShowDetailsVC = TVShowDetailsVCBuilder.build(tvShow:tvShow)
        viewController.navigationController?.pushViewController(tvShowDetailsVC, animated: true)
    }
}


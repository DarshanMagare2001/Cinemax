//
//  HomeVCRouter.swift
//  Cinemax
//
//  Created by IPS-161 on 06/02/24.
//

import Foundation
import UIKit

protocol HomeVCRouterProtocol {
    func gotoDetailVC(movieData: MasterMovieModelResult?)
    func gotoSeeAllVC(page: Int?,searchText: String?,movieId: Int?,seeAllVCInputs: SeeAllVCInputs?)
}

class HomeVCRouter {
    var viewController: UIViewController
    init(viewController: UIViewController){
        self.viewController = viewController
    }
}

extension HomeVCRouter: HomeVCRouterProtocol {
    func gotoDetailVC(movieData: MasterMovieModelResult?){
        let detailVC = DetailVCBuilder.build(movieData: movieData)
        viewController.navigationController?.pushViewController(detailVC, animated: false)
    }
    func gotoSeeAllVC(page: Int?,searchText: String?,movieId: Int?,seeAllVCInputs: SeeAllVCInputs?){
        let seeAllVC = SeeAllVCBuilder.build(page: page, searchText: searchText, movieId: movieId, seeAllVCInputs: seeAllVCInputs)
        viewController.navigationController?.pushViewController(seeAllVC, animated: false)
    }
}


//
//  DetailVCRouter.swift
//  Cinemax
//
//  Created by IPS-161 on 20/03/24.
//

import Foundation
import UIKit

protocol DetailVCRouterProtocol  {
    func gotoDetailVC(movieData: MasterMovieModelResult?)
    func gotoSeeAllVC(page: Int?,searchText: String?,movieId: Int?,seeAllVCInputs: SeeAllVCInputs?)
}

class DetailVCRouter {
    var viewController: UIViewController
    init(viewController: UIViewController){
        self.viewController = viewController
    }
}

extension DetailVCRouter: DetailVCRouterProtocol {
    func gotoDetailVC(movieData: MasterMovieModelResult?){
        let detailVC = DetailVCBuilder.build(movieData: movieData)
        viewController.navigationController?.pushViewController(detailVC, animated: true)
    }
    func gotoSeeAllVC(page: Int?,searchText: String?,movieId: Int?,seeAllVCInputs: SeeAllVCInputs?){
        let seeAllVC = SeeAllVCBuilder.build(genreId: 0, page: page, searchText: searchText, movieId: movieId, seeAllVCInputs: seeAllVCInputs)
        viewController.navigationController?.pushViewController(seeAllVC, animated: true)
    }
}

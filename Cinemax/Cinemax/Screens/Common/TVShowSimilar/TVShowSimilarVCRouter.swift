//
//  TVShowSimilarVCRouter.swift
//  Cinemax
//
//  Created by IPS-161 on 29/03/24.
//

import Foundation
import UIKit

protocol TVShowSimilarVCRouterProtocol {
    func gotoTVShowDetailsVC(tvShow: TVShowsResponseModelResult?)
}

class TVShowSimilarVCRouter {
    var viewController: UIViewController
    init(viewController: UIViewController){
        self.viewController = viewController
    }
}

extension TVShowSimilarVCRouter: TVShowSimilarVCRouterProtocol {
    func gotoTVShowDetailsVC(tvShow: TVShowsResponseModelResult?){
        let tvShowDetailsVC = TVShowDetailsVCBuilder.build(tvShow:tvShow)
        viewController.navigationController?.pushViewController(tvShowDetailsVC, animated: true)
    }
}

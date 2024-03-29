//
//  TVShowDetailsVCRouter.swift
//  Cinemax
//
//  Created by IPS-161 on 27/03/24.
//

import Foundation
import UIKit

protocol TVShowDetailsVCRouterProtocol {
    func gotoTVShowDetailsVC(tvShow: TVShowsResponseModelResult?)
    func gotoTVShowSimilarVC()
}

class TVShowDetailsVCRouter {
    var viewController: UIViewController
    init(viewController: UIViewController){
        self.viewController = viewController
    }
}

extension TVShowDetailsVCRouter: TVShowDetailsVCRouterProtocol {
    func gotoTVShowDetailsVC(tvShow: TVShowsResponseModelResult?){
        let tvShowDetailsVC = TVShowDetailsVCBuilder.build(tvShow:tvShow)
        viewController.navigationController?.pushViewController(tvShowDetailsVC, animated: true)
    }
    func gotoTVShowSimilarVC(){
        let tvShowSimilarVC = TVShowSimilarVCBuilder.build()
        viewController.navigationController?.pushViewController(tvShowSimilarVC, animated: true)
    }
}

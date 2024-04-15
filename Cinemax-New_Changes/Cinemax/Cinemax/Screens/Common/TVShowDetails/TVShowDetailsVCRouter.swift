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
    func gotoTVShowSimilarVC(tvShowData: TVShowsResponseModelResult?, page: Int?)
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
    func gotoTVShowSimilarVC(tvShowData: TVShowsResponseModelResult?, page: Int?){
        let tvShowSimilarVC = TVShowSimilarVCBuilder.build(tvShowData: tvShowData, page: page)
        viewController.navigationController?.pushViewController(tvShowSimilarVC, animated: true)
    }
}

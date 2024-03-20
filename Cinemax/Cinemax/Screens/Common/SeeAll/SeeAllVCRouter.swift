//
//  SeeAllVCRouter.swift
//  Cinemax
//
//  Created by IPS-161 on 19/03/24.
//

import Foundation
import UIKit

protocol SeeAllVCRouterProtocol {
    func gotoDetailVC(movieData: MasterMovieModelResult?)
}

class SeeAllVCRouter {
    var viewController: UIViewController
    init(viewController: UIViewController){
        self.viewController = viewController
    }
}

extension SeeAllVCRouter: SeeAllVCRouterProtocol {
    func gotoDetailVC(movieData: MasterMovieModelResult?){
        let detailVC = DetailVCBuilder.build(movieData: movieData)
        viewController.navigationController?.pushViewController(detailVC, animated: true)
    }
}

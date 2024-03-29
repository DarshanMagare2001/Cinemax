//
//  TVShowSimilarVCRouter.swift
//  Cinemax
//
//  Created by IPS-161 on 29/03/24.
//

import Foundation
import UIKit

protocol TVShowSimilarVCRouterProtocol {
    
}

class TVShowSimilarVCRouter {
    var viewController: UIViewController
    init(viewController: UIViewController){
        self.viewController = viewController
    }
}

extension TVShowSimilarVCRouter: TVShowSimilarVCRouterProtocol {
    
}

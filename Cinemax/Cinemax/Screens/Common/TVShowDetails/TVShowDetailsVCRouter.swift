//
//  TVShowDetailsVCRouter.swift
//  Cinemax
//
//  Created by IPS-161 on 27/03/24.
//

import Foundation
import UIKit

protocol TVShowDetailsVCRouterProtocol {
    
}

class TVShowDetailsVCRouter {
    var viewController: UIViewController
    init(viewController: UIViewController){
        self.viewController = viewController
    }
}

extension TVShowDetailsVCRouter: TVShowDetailsVCRouterProtocol {
    
}

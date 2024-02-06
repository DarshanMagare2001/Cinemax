//
//  HomeVCRouter.swift
//  Cinemax
//
//  Created by IPS-161 on 06/02/24.
//

import Foundation
import UIKit

protocol HomeVCRouterProtocol {
    
}

class HomeVCRouter {
    var viewController: UIViewController
    init(viewController: UIViewController){
        self.viewController = viewController
    }
}
 
extension HomeVCRouter: HomeVCRouterProtocol {
    
}


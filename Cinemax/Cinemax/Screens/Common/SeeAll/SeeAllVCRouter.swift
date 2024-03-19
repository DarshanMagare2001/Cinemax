//
//  SeeAllVCRouter.swift
//  Cinemax
//
//  Created by IPS-161 on 19/03/24.
//

import Foundation
import UIKit

protocol SeeAllVCRouterProtocol {
    
}

class SeeAllVCRouter {
    var viewController: UIViewController
    init(viewController: UIViewController){
        self.viewController = viewController
    }
}

extension SeeAllVCRouter: SeeAllVCRouterProtocol {
    
}

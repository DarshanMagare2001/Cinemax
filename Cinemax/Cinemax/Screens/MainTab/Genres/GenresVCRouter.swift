//
//  GenresVCRouter.swift
//  Cinemax
//
//  Created by IPS-161 on 03/04/24.
//

import Foundation
import UIKit

protocol GenresVCRouterProtocol {
    
}

class GenresVCRouter {
    var viewController: UIViewController
    init(viewController: UIViewController){
        self.viewController = viewController
    }
}

extension GenresVCRouter: GenresVCRouterProtocol {
    
}

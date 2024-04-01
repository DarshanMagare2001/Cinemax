//
//  SearchVCRouter.swift
//  Cinemax
//
//  Created by IPS-161 on 01/04/24.
//

import Foundation
import UIKit

protocol SearchVCRouterProtocol {
    
}

class SearchVCRouter {
    var viewController: UIViewController
    init(viewController: UIViewController){
        self.viewController = viewController
    }
}

extension SearchVCRouter: SearchVCRouterProtocol {
    
}


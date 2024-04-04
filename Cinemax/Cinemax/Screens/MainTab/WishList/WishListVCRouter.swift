//
//  WishListVCRouter.swift
//  Cinemax
//
//  Created by IPS-161 on 04/04/24.
//

import Foundation
import UIKit

protocol WishListVCRouterProtocol {
    
}

class WishListVCRouter {
    var viewController: UIViewController
    init(viewController: UIViewController){
        self.viewController = viewController
    }
}

extension WishListVCRouter: WishListVCRouterProtocol {
    
}

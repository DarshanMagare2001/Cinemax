//
//  ProfileVCRouter.swift
//  Cinemax
//
//  Created by IPS-161 on 01/02/24.
//

import Foundation
import UIKit

protocol ProfileVCRouterProtocol {
    
}

class ProfileVCRouter {
    var viewController: UIViewController
    init(viewController: UIViewController){
        self.viewController = viewController
    }
}

extension ProfileVCRouter: ProfileVCRouterProtocol {
    
}


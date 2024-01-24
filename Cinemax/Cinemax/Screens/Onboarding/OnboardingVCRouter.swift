//
//  OnboardingVCRouter.swift
//  Cinemax
//
//  Created by IPS-161 on 24/01/24.
//

import Foundation
import UIKit

protocol OnboardingVCRouterProtocol {
    
}

class OnboardingVCRouter {
    var viewController: UIViewController
    init(viewController: UIViewController){
        self.viewController = viewController
    }
}

extension OnboardingVCRouter: OnboardingVCRouterProtocol {
    
}


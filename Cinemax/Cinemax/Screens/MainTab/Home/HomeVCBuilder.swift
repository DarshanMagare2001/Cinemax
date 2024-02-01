//
//  HomeVCBuilder.swift
//  Cinemax
//
//  Created by IPS-161 on 01/02/24.
//

import Foundation
import UIKit

public final class HomeVCBuilder {
    static func build(factor:NavigationFactoryClosure) -> UIViewController {
        let storyboard = UIStoryboard.Home
        let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        return factor(homeVC)
    }
}

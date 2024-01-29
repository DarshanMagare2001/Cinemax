//
//  LoginVCBuilder.swift
//  Cinemax
//
//  Created by IPS-161 on 25/01/24.
//

import Foundation
import UIKit

public final class LoginVCBuilder {
    static func build(factory:NavigationFactoryClosure) -> UIViewController {
        let storyboard = UIStoryboard.Authentication
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        return factory(loginVC)
    }
}

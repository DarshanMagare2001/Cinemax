//
//  SignUpVCBuilder.swift
//  Cinemax
//
//  Created by IPS-161 on 29/01/24.
//

import Foundation
import UIKit

public final class SignUpVCBuilder {
    static func build(factory:NavigationFactoryClosure) -> UIViewController {
        let storyboard = UIStoryboard.Authentication
        let loginVC = storyboard.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        return factory(loginVC)
    }
}


//
//  ProfileVCBuilder.swift
//  Cinemax
//
//  Created by IPS-161 on 01/02/24.
//

import Foundation
import UIKit

public final class ProfileVCBuilder {
    static func build(factor:NavigationFactoryClosure) -> UIViewController {
        let storyboard = UIStoryboard.Profile
        let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        profileVC.title = "Profile"
        return factor(profileVC)
    }
}

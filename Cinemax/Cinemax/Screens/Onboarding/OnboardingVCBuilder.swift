//
//  OnboardingVCBuilder.swift
//  Cinemax
//
//  Created by IPS-161 on 24/01/24.
//

import Foundation
import UIKit

public final class OnboardingVCBuilder {
    static func build() -> UIViewController {
        let storyboard = UIStoryboard.Onboarding
        let onboardingVC = storyboard.instantiateViewController(withIdentifier: "OnboardingVC") as! OnboardingVC
        return onboardingVC
    }
}

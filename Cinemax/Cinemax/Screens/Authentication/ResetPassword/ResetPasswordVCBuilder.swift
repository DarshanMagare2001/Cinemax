//
//  ResetPasswordVCBuilder.swift
//  Cinemax
//
//  Created by IPS-161 on 29/01/24.
//

import Foundation
import UIKit

public final class ResetPasswordVCBuilder {
    static func build() -> UIViewController {
        let storyboard = UIStoryboard.Authentication
        let resetPasswordVC = storyboard.instantiateViewController(withIdentifier: "ResetPasswordVC") as! ResetPasswordVC
        return resetPasswordVC
    }
}

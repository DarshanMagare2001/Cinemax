//
//  SignUpCredentialVCBuilder.swift
//  Cinemax
//
//  Created by IPS-161 on 29/01/24.
//

import Foundation
import UIKit

public final class SignUpCredentialVCBuilder {
    static func build() -> UIViewController {
        let storyboard = UIStoryboard.Authentication
        let signUpCredentialVC = storyboard.instantiateViewController(withIdentifier: "SignUpCredentialVC") as! SignUpCredentialVC
        return signUpCredentialVC
    }
}

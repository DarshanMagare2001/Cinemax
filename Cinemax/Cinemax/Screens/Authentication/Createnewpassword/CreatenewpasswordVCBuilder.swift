//
//  CreatenewpasswordVCBuilder.swift
//  Cinemax
//
//  Created by IPS-161 on 29/01/24.
//

import Foundation
import UIKit

public final class CreatenewpasswordVCBuilder {
    static func build() -> UIViewController {
        let storyboard = UIStoryboard.Authentication
        let createnewpasswordVC = storyboard.instantiateViewController(withIdentifier: "CreatenewpasswordVC") as! CreatenewpasswordVC
        return createnewpasswordVC
    }
}

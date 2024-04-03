//
//  GenresVCBuilder.swift
//  Cinemax
//
//  Created by IPS-161 on 03/04/24.
//

import Foundation
import UIKit

public final class GenresVCBuilder {
    static func build(factor:NavigationFactoryClosure) -> UIViewController {
        let storyboard = UIStoryboard.Genres
        let genresVC = storyboard.instantiateViewController(withIdentifier: "GenresVC") as! GenresVC
        return factor(genresVC)
    }
}

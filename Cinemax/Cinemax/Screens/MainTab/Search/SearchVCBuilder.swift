//
//  SearchVCBuilder.swift
//  Cinemax
//
//  Created by IPS-161 on 01/02/24.
//

import Foundation
import UIKit

public final class SearchVCBuilder {
    static func build() -> UIViewController {
        let storyboard = UIStoryboard.Search
        let searchVC = storyboard.instantiateViewController(withIdentifier: "SearchVC") as! SearchVC
        return searchVC
    }
}


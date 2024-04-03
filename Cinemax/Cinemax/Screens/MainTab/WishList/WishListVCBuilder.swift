//
//  WishListVCBuilder.swift
//  Cinemax
//
//  Created by IPS-161 on 03/04/24.
//

import Foundation
import UIKit

public final class WishListVCBuilder {
    static func build(factor:NavigationFactoryClosure) -> UIViewController {
        let storyboard = UIStoryboard.WishList
        let wishListVC = storyboard.instantiateViewController(withIdentifier: "WishListVC") as! WishListVC
        return factor(wishListVC)
    }
}

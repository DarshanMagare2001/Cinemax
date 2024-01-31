//
//  LoaderVCViewModel.swift
//  Cinemax
//
//  Created by IPS-161 on 31/01/24.
//

import UIKit
import NVActivityIndicatorView

class Loader: NSObject {
    static let shared = Loader()
    private var presentedLoaderVC: UIViewController?
    
    func showLoader(type: NVActivityIndicatorType,color: UIColor) {
        let storyboard = UIStoryboard.Common
        let loaderVC = storyboard.instantiateViewController(withIdentifier: "LoaderVC") as! LoaderVC
        if let viewController = UIApplication.shared.keyWindow?.rootViewController {
            loaderVC.modalPresentationStyle = .overFullScreen
            loaderVC.type = type
            loaderVC.color = color
            viewController.present(loaderVC, animated: true, completion: nil)
            self.presentedLoaderVC = loaderVC
        }
    }
    
    func hideLoader() {
        if let loaderVC = presentedLoaderVC {
            loaderVC.dismiss(animated: true, completion: nil)
            presentedLoaderVC = nil // Reset the reference
        }
    }
    
}

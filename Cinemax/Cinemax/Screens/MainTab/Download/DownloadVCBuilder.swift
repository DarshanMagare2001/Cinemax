//
//  DownloadVCBuilder.swift
//  Cinemax
//
//  Created by IPS-161 on 01/02/24.
//

import Foundation
import UIKit

public final class DownloadVCBuilder {
    static func build() -> UIViewController {
        let storyboard = UIStoryboard.Download
        let downloadVC = storyboard.instantiateViewController(withIdentifier: "DownloadVC") as! DownloadVC
        return downloadVC
    }
}



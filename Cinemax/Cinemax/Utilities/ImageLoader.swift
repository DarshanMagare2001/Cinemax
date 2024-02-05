//
//  ImageLoader.swift
//  Cinemax
//
//  Created by IPS-161 on 05/02/24.
//

import Foundation
import UIKit

class ImageLoader {
    
    private static let imageCache = NSCache<AnyObject, UIImage>()
    
    static func loadImage(imageView: UIImageView, imageUrl: String) {
        
        // Show activity indicator
        let activityLoader = UIActivityIndicatorView(style: .gray)
        activityLoader.startAnimating()
        activityLoader.center = imageView.center
        imageView.addSubview(activityLoader)
        
        if let cachedImage = self.imageCache.object(forKey: imageUrl as AnyObject) {
            // Image already cached
            DispatchQueue.main.async {
                activityLoader.removeFromSuperview()
                imageView.image = cachedImage
            }
        } else {
            // Image not cached, download it
            DispatchQueue.global(qos: .background).async {
                if let imageData = try? Data(contentsOf: URL(string: imageUrl)!) {
                    if let image = UIImage(data: imageData) {
                        self.imageCache.setObject(image, forKey: imageUrl as AnyObject)
                        DispatchQueue.main.async {
                            activityLoader.removeFromSuperview()
                            imageView.image = image
                        }
                    }
                } else {
                    // Handle download failure if needed
                    DispatchQueue.main.async {
                        activityLoader.removeFromSuperview()
                    }
                }
            }
        }
    }
}

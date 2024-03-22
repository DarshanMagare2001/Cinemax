//
//  MoviesGalleryCollectionViewCell.swift
//  Cinemax
//
//  Created by IPS-161 on 22/03/24.
//

import UIKit
import YouTubePlayer

class MoviesGalleryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var movieVideoView: YouTubePlayerView!
    @IBOutlet weak var movieVideoTitleLbl: UILabel!
    func configure(trailer:Trailer){
        if let trailerKey = trailer.key , let trailerTitle = trailer.name {
            if let myVideoURL = URL(string: "https://www.youtube.com/watch?v=\(trailerKey)") {
                DispatchQueue.main.async { [weak self] in
                    self?.movieVideoView.loadVideoURL(myVideoURL)
                    self?.movieVideoTitleLbl.text = trailerTitle
                }
            }
        }
    }
}

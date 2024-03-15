//
//  DetailVC.swift
//  Cinemax
//
//  Created by IPS-161 on 14/03/24.
//

import UIKit

protocol DetailVCProtocol : AnyObject {
    func updateUI(movieDetail:MovieDetailsModel)
}

class DetailVC: UIViewController {
    
    @IBOutlet weak var movieBackgroundImg: UIImageView!
    var presenter : DetailVCPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidload()
    }
    
    func backBtnPressed(){
        navigationController?.popViewController(animated: true)
    }
    
}

extension DetailVC : DetailVCProtocol {
    
    func updateUI(movieDetail:MovieDetailsModel){
        let movieBackgroundImgUrl = "https://image.tmdb.org/t/p/w500\(movieDetail.posterPath)"
        movieBackgroundImg.loadImage(urlString: movieBackgroundImgUrl, placeholder: "frame.fill")
    }
    
}

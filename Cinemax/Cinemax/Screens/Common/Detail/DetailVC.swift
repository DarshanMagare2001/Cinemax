//
//  DetailVC.swift
//  Cinemax
//
//  Created by IPS-161 on 14/03/24.
//

import UIKit

protocol DetailVCProtocol : AnyObject {
    func updateUI(movieImgUrl:String)
}

class DetailVC: UIViewController {
    
    @IBOutlet weak var movieImg: UIImageView!
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
    
    func updateUI(movieImgUrl:String){
        movieImg.loadImage(urlString: movieImgUrl, placeholder: "person.fill")
    }
    
}

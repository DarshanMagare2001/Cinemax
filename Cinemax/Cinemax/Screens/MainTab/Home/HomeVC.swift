//
//  HomeVC.swift
//  Cinemax
//
//  Created by IPS-161 on 01/02/24.
//

import UIKit

protocol HomeVCProtocol: class {
    func setupUI(name:String,profileImgUrl:String)
    func updateUI()
}

class HomeVC: UIViewController {
    
    @IBOutlet weak var userImg: CircleImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    
    var presenter: HomeVCPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidload()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
}

extension HomeVC: HomeVCProtocol {
    
    func setupUI(name:String,profileImgUrl:String){
        userNameLbl.text = name
        ImageLoader.loadImage(imageView: userImg, imageUrl: profileImgUrl, placeHolderType: .systemName, placeHolderImage: "person.fill")
    }
    
    func updateUI(){
     
    }
    
}

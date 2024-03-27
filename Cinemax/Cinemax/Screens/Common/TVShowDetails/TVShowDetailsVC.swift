//
//  TVShowDetailsVC.swift
//  Cinemax
//
//  Created by IPS-161 on 27/03/24.
//

import UIKit

protocol TVShowDetailsVCProtocol: AnyObject {
    
}

class TVShowDetailsVC: UIViewController {
    
    @IBOutlet weak var tvShowBackgroundImg: UIImageView!
    var presenter: TVShowDetailsVCPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidload()
    }
    
    func backBtnPressed(){
        navigationController?.popViewController(animated: true)
    }
    
}

extension TVShowDetailsVC:  TVShowDetailsVCProtocol {
    
}

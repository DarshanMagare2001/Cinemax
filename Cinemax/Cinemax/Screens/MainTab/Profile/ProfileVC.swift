//
//  ProfileVC.swift
//  Cinemax
//
//  Created by IPS-161 on 01/02/24.
//

import UIKit

protocol ProfileVCProtocol : class {
    
}


class ProfileVC: UIViewController {

    var presenter : ProfileVCPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidload()
    }
 
    @IBAction func logOutbtnPressed(_ sender: UIButton) {
        
    }
    
}

extension ProfileVC : ProfileVCProtocol {
    
}

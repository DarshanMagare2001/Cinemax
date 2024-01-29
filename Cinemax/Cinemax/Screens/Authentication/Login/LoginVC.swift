//
//  LoginVC.swift
//  Cinemax
//
//  Created by IPS-161 on 25/01/24.
//

import UIKit

protocol LoginVCProtocol: class {
    
}

class LoginVC: UIViewController {
    
    var presenter: LoginVCPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidload()
    }
  

}

extension LoginVC: LoginVCProtocol {
    
}

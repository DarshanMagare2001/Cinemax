//
//  SignUpCredentialVC.swift
//  Cinemax
//
//  Created by IPS-161 on 29/01/24.
//

import UIKit

protocol SignUpCredentialVCProtocol: class {
    
}

class SignUpCredentialVC: UIViewController {
    
    var presenter: SignUpCredentialVCPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidload()
    }
    
    func backBtnPressed(){
        navigationController?.popViewController(animated: true)
    }
    
  
}

extension SignUpCredentialVC: SignUpCredentialVCProtocol {
    
}

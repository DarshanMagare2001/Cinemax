//
//  SignUpVC.swift
//  Cinemax
//
//  Created by IPS-161 on 29/01/24.
//

import UIKit

protocol SignUpVCProtocol: class {
    
}

class SignUpVC: UIViewController {
    
    var presenter: SignUpVCPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidload()
    }
    
    @IBAction func signUpBtnPressed(_ sender: UIButton) {
        presenter?.goToSignUpCredentialVC()
    }
    
    
    @IBAction func loginBtnPressed(_ sender: UIButton) {
        presenter?.goToLoginVC()
    }
    
}

extension SignUpVC : SignUpVCProtocol {
    
}

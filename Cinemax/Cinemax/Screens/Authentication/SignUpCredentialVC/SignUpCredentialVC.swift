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
    
    @IBOutlet weak var fullNameTxtFld: UITextField!
    @IBOutlet weak var emailaddressTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    @IBOutlet weak var passwordShowHideBtn: UIButton!
    @IBOutlet weak var privacyAndPolicyBtn: UIButton!
    @IBOutlet weak var termsANdConditionLblView: UIView!
    
    var presenter: SignUpCredentialVCPresenterProtocol?
    var isPassworShow = false {
        didSet{
            passwordShowHideBtn.setImage(UIImage(named: isPassworShow ? "EyeBtnOpen" : "EyeBtnClose"), for: .normal)
        }
    }
    var isTermsAndConditionCheck = false {
        didSet{
            privacyAndPolicyBtn.setImage(UIImage(systemName: isTermsAndConditionCheck ? "checkmark.square" : "square"), for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidload()
    }
    
    func backBtnPressed(){
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func passwordShowHideBtnPressed(_ sender: UIButton) {
        isPassworShow.toggle()
    }
    
    @IBAction func privacyAndPolicyBtnPressed(_ sender: UIButton) {
        isTermsAndConditionCheck.toggle()
    }
    
    @IBAction func signUpBtnPressed(_ sender: UIButton) {
        
    }
    
    
}

extension SignUpCredentialVC: SignUpCredentialVCProtocol {
    
}

//
//  LoginVC.swift
//  Cinemax
//
//  Created by IPS-161 on 25/01/24.
//

import UIKit

protocol LoginVCProtocol: class {
    func updateUI()
}

class LoginVC: UIViewController {
    
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var emailAdressTxtFld: UITextField!
    @IBOutlet weak var emailWarningLbl: RoundedLabelWithBorder!
    @IBOutlet weak var passwordTxtFld: UITextField!
    @IBOutlet weak var passwordShowHideBtn: UIButton!
    @IBOutlet weak var passwordWarningLbl: RoundedLabelWithBorder!
    @IBOutlet weak var logInBtn: RoundedButton!
    
    var presenter: LoginVCPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidload()
    }
    
    
    @IBAction func forgetPasswordBtnPrressed(_ sender: UIButton) {
        presenter?.goToResetPasswordVC()
    }
    
    
    @IBAction func logInBtnPressed(_ sender: UIButton) {
        
    }
    
}

extension LoginVC: LoginVCProtocol {
    
    func updateUI(){
        if let name = UserdefaultRepositoryManager.fetchUserInfoFromUserdefault(type: .currentUsersName){
            headingLbl.text = "Hi,\(name)"
        }
    }
    
    func backBtnPressed(){
        navigationController?.popViewController(animated: true)
    }
    
}

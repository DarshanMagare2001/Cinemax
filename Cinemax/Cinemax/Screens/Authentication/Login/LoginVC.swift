//
//  LoginVC.swift
//  Cinemax
//
//  Created by IPS-161 on 25/01/24.
//

import UIKit
import RxSwift

protocol LoginVCProtocol: class {
    func updateUI()
    func setUpBinding()
}

class LoginVC: UIViewController {
    
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var emailAdressTxtFld: UITextField!
    @IBOutlet weak var emailWarningLbl: RoundedLabelWithBorder!
    @IBOutlet weak var passwordTxtFld: UITextField!
    @IBOutlet weak var passwordShowHideBtn: UIButton!
    @IBOutlet weak var passwordWarningLbl: RoundedLabelWithBorder!
    @IBOutlet weak var logInBtn: RoundedButton!
    
    var presenter : LoginVCPresenterProtocol?
    var presenterProducer : LoginVCPresenterProtocol.Producer!
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInputs()
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
        emailWarningLbl.isHidden = true
        passwordWarningLbl.isHidden = true
    }
    
    func setupInputs(){
        presenter = presenterProducer((
            email: emailAdressTxtFld.rx.text.orEmpty.asDriver(),
            password: passwordTxtFld.rx.text.orEmpty.asDriver(),
            login: logInBtn.rx.tap.asDriver()
        ))
    }
    
    func setUpBinding(){
        presenter?.output.enableLogin.debug("Enable Login Driver" , trimOutput: false)
            .drive(logInBtn.rx.isEnabled)
            .disposed(by: bag)
        
        presenter?.output.emailWarning.debug("Enable Login Driver" , trimOutput: false)
            .drive(emailWarningLbl.rx.isHidden)
            .disposed(by: bag)
        
        presenter?.output.passwordWarning.debug("Enable Login Driver" , trimOutput: false)
            .drive(passwordWarningLbl.rx.isHidden)
            .disposed(by: bag)
    }
    
    
    func backBtnPressed(){
        navigationController?.popViewController(animated: true)
    }
    
}

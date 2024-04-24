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
    func errorAlert(message:String)
}

class LoginVC: UIViewController {
    
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var emailAdressTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    @IBOutlet weak var logInBtn: RoundedButton!
    @IBOutlet weak var passwordShowHideBtn: UIButton!
    
    var presenter : LoginVCPresenterProtocol?
    var presenterProducer : LoginVCPresenterProtocol.Producer!
    private let bag = DisposeBag()
    var isPassworShow = false {
        didSet{
            passwordShowHideBtn.setImage(UIImage(named: isPassworShow ? "EyeBtnOpen" : "EyeBtnClose"), for: .normal)
            passwordTxtFld.isSecureTextEntry = isPassworShow ? false : true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInputs()
        presenter?.viewDidload()
    }
    
    
    @IBAction func forgetPasswordBtnPrressed(_ sender: UIButton) {
        presenter?.goToResetPasswordVC()
    }
    
    
    @IBAction func passwordShowHideBtnPressed(_ sender: UIButton) {
        isPassworShow.toggle()
    }
    
    
    @IBAction func logInBtnPressed(_ sender: UIButton) {
        presenter?.signIn(email: emailAdressTxtFld.text, password: passwordTxtFld.text)
    }
    
}

extension LoginVC: LoginVCProtocol {
    
    func updateUI(){
        if let name = UserdefaultRepositoryManager.fetchUserInfoFromUserdefault(type: .currentUsersName){
            headingLbl.text = "Hi,\(name)"
        }
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
    }
    
    
    func errorAlert(message:String){
        Alert.shared.alertOk(title: "Error", message: message, presentingViewController: self) { _ in}
    }
    
    func backBtnPressed(){
        navigationController?.popViewController(animated: true)
    }
    
}

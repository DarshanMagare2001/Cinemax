//
//  LoginVC.swift
//  Cinemax
//
//  Created by IPS-161 on 25/01/24.
//

import UIKit
import RxSwift
import RxCocoa

protocol LoginVCProtocol: class {
    func updateUI()
    func setUpBinding()
    func errorMsg(message:String)
}

class LoginVC: UIViewController {
    
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var emailAdressTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    @IBOutlet weak var logInBtn: RoundedButton!
    @IBOutlet weak var passwordShowHideBtn: UIButton!
    @IBOutlet weak var emailAdressTxtFldView: RoundedCornerView!
    @IBOutlet weak var passwordTxtFldView: RoundedCornerView!
    
    var presenter : LoginVCPresenterProtocol?
    var presenterProducer : LoginVCPresenterProtocol.Producer!
    private let bag = DisposeBag()
    var isPassworShow = false {
        didSet{
            passwordShowHideBtn.setImage(UIImage(named: isPassworShow ? "EyeBtnOpen" : "EyeBtnClose"), for: .normal)
            passwordTxtFld.isSecureTextEntry = isPassworShow ? false : true
        }
    }
    var doLogin: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
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
        if(doLogin.value){
            presenter?.signIn(email: emailAdressTxtFld.text, password: passwordTxtFld.text)
        }else{
            showErrors()
        }
    }
    
}

extension LoginVC: LoginVCProtocol {
    
    func updateUI(){
        if let name = UserdefaultRepositoryManager.fetchUserInfoFromUserdefault(type: .currentUsersFirstName){
            headingLbl.text = "Hi,\(name)"
        }
    }
    
    func setupInputs(){
        presenter = presenterProducer((
            email: emailAdressTxtFld.rx.text.orEmpty.asDriver(),
            password: passwordTxtFld.rx.text.orEmpty.asDriver()
        ))
        emailAdressTxtFld.addTarget(self, action: #selector(textFieldDidChangeForEmailAddressTxtFld(_:)), for: .editingChanged)
        passwordTxtFld.addTarget(self, action: #selector(textFieldDidChangeForPasswordTxtFld(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChangeForEmailAddressTxtFld(_ textField: UITextField) {
        emailAdressTxtFldView.borderColor = UIColor.appBlue!
    }
    @objc func textFieldDidChangeForPasswordTxtFld(_ textField: UITextField) {
        passwordTxtFldView.borderColor = UIColor.appBlue!
    }
    
    func setUpBinding(){
        presenter?.output.enableLogin
            .debug("Enable Login Driver", trimOutput: false)
            .drive { [weak self] enableLogin in
                self?.doLogin.accept(enableLogin)
            }
            .disposed(by: bag)
    }
    
    func showErrors(){
        if (emailAdressTxtFld.text!.isEmpty) && (passwordTxtFld.text!.isEmpty) {
            showAllErrorVisuals()
            alertMsg(message: "Please fill Credentials.")
        }else if !(emailAdressTxtFld.text!.isEmailValid()) {
            if(emailAdressTxtFld.text!.isEmpty){
                alertMsg(message:"Fill Email.")
            }else{
                self.alertMsg(message:"Fill email in correct format.")
            }
            emailAdressTxtFldView.borderColor = .red
            emailAdressTxtFld.shake(duration: 0.07, repeatCount: 4, autoreverses: true)
        }else if !(passwordTxtFld.text!.isPasswordValid()) {
            if(passwordTxtFld.text!.isEmpty){
                alertMsg(message:"Fill Password.")
            }else{
                self.alertMsg(message:"Password should be 6 characters and contain at least one alphabet, one integer, and one symbol.")
            }
            passwordTxtFldView.borderColor = .red
            passwordTxtFld.shake(duration: 0.07, repeatCount: 4, autoreverses: true)
        }
    }
    
    func showAllErrorVisuals(){
        emailAdressTxtFldView.borderColor = .red
        emailAdressTxtFld.shake(duration: 0.07, repeatCount: 4, autoreverses: true)
        passwordTxtFldView.borderColor = .red
        passwordTxtFld.shake(duration: 0.07, repeatCount: 4, autoreverses: true)
    }
    
    func alertMsg(message:String){
        let customPopVC = CustomPopupVCBuilder.build(customPopupVCInputs: CustomPopupVCInputs.alert, popupLblHeadlineInput: "Alert!", popupSubheadlineInput: message)
        customPopVC.modalPresentationStyle = .overCurrentContext
        navigationController?.present(customPopVC,animated: true)
    }
    
    func errorMsg(message:String){
        let customPopVC = CustomPopupVCBuilder.build(customPopupVCInputs: CustomPopupVCInputs.error, popupLblHeadlineInput: "Error!", popupSubheadlineInput: message)
        customPopVC.modalPresentationStyle = .overCurrentContext
        navigationController?.present(customPopVC,animated: true)
    }
    
    func backBtnPressed(){
        navigationController?.popViewController(animated: true)
    }
    
}

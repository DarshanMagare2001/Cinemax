//
//  SignUpCredentialVC.swift
//  Cinemax
//
//  Created by IPS-161 on 29/01/24.
//

import UIKit
import RxCocoa
import RxSwift

protocol SignUpCredentialVCProtocol: class {
    func setupInputs()
    func setUpBinding()
}

class SignUpCredentialVC: UIViewController {
    
    @IBOutlet weak var fullNameTxtFld: UITextField!
    @IBOutlet weak var emailaddressTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    @IBOutlet weak var passwordShowHideBtn: UIButton!
    @IBOutlet weak var privacyAndPolicyBtn: UIButton!
    @IBOutlet weak var termsANdConditionLblView: UIView!
    @IBOutlet weak var signUpBtn: RoundedButton!
    
    var presenter : SignUpCredentialVCPresenterProtocol?
    var presenterProducer : SignUpCredentialVCPresenterProtocol.Producer!
    var isPassworShow = false {
        didSet{
            passwordShowHideBtn.setImage(UIImage(named: isPassworShow ? "EyeBtnOpen" : "EyeBtnClose"), for: .normal)
            passwordTxtFld.isSecureTextEntry = isPassworShow ? false : true
        }
    }
    var isTermsAndConditionCheck = false {
        didSet{
            privacyAndPolicyBtn.setImage(UIImage(systemName: isTermsAndConditionCheck ? "checkmark.square" : "square"), for: .normal)
        }
    }
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInputs()
        presenter?.viewDidload()
        //        setupInputs()
        //        setUpBinding()
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
    func setupInputs() {
        presenter = presenterProducer((
            email : emailaddressTxtFld.rx.text.orEmpty.asDriver(),
            password : passwordTxtFld.rx.text.orEmpty.asDriver(),
            fullName : fullNameTxtFld.rx.text.orEmpty.asDriver(),
            login:signUpBtn.rx.tap.asDriver()
        ))
    }
    
    func setUpBinding(){
        presenter?.output.enableLogin.debug("Enable Login Driver" , trimOutput: false)
            .drive(signUpBtn.rx.isEnabled)
            .disposed(by: bag)
    }
}

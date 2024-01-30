//
//  SignUpCredentialVC.swift
//  Cinemax
//
//  Created by IPS-161 on 29/01/24.
//

import UIKit
import RxCocoa
import RxSwift
import RxRelay

protocol SignUpCredentialVCProtocol: class {
    func setupInputs()
    func setUpBinding()
    func setupWarningLbls()
}

class SignUpCredentialVC: UIViewController {
    
    @IBOutlet weak var fullNameTxtFld: UITextField!
    @IBOutlet weak var emailaddressTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    @IBOutlet weak var passwordShowHideBtn: UIButton!
    @IBOutlet weak var privacyAndPolicyBtn: UIButton!
    @IBOutlet weak var termsANdConditionLblView: UIView!
    @IBOutlet weak var signUpBtn: RoundedButton!
    @IBOutlet weak var fullNameWarningLbl: RoundedLabelWithBorder!
    @IBOutlet weak var emailWarningLbl: RoundedLabelWithBorder!
    @IBOutlet weak var passwordWarningLbl: RoundedLabelWithBorder!
    
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
    
    var isTermsAndConditionCheckDriver: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInputs()
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
        isTermsAndConditionCheckDriver.accept(isTermsAndConditionCheck)
    }
    
    
    @IBAction func signUpBtnPressed(_ sender: UIButton) {
        
    }
    
}

extension SignUpCredentialVC: SignUpCredentialVCProtocol {
    
    func setupWarningLbls(){
        fullNameWarningLbl.isHidden = true
        emailWarningLbl.isHidden = true
        passwordWarningLbl.isHidden = true
    }
    
    func setupInputs() {
        presenter = presenterProducer((
            email: emailaddressTxtFld.rx.text.orEmpty.asDriver(),
            password: passwordTxtFld.rx.text.orEmpty.asDriver(),
            fullName: fullNameTxtFld.rx.text.orEmpty.asDriver(),
            isTermsAndConditionAccept: isTermsAndConditionCheckDriver.asDriver(),
            login: signUpBtn.rx.tap.asDriver()
        ))
    }
    
    func setUpBinding(){
        presenter?.output.enableLogin.debug("Enable Login Driver" , trimOutput: false)
            .drive(signUpBtn.rx.isEnabled)
            .disposed(by: bag)
    }
}

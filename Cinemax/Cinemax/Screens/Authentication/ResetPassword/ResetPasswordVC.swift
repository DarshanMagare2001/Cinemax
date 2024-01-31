//
//  ResetPasswordVC.swift
//  Cinemax
//
//  Created by IPS-161 on 29/01/24.
//

import UIKit
import RxSwift

protocol ResetPasswordVCPrtocol: class {
    func updateUI()
    func setUpBinding()
}

class ResetPasswordVC: UIViewController {
    
    @IBOutlet weak var resetPasswordView: UIView!
    @IBOutlet weak var verificationView: UIView!
    @IBOutlet weak var emailAddressTxtFld: UITextField!
    @IBOutlet weak var emailWarningLbl: RoundedLabelWithBorder!
    @IBOutlet weak var nxtBtn: RoundedButton!
    
    var presenter : ResetPasswordVCPresenterProtocol?
    var presenterProducer : ResetPasswordVCPresenterProtocol.Producer!
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInputs()
        presenter?.viewDidload()
    }
    
    @IBAction func nxtBtnPressed(_ sender: UIButton) {
        UIView.transition(with: view, duration: 0.5, options: .transitionFlipFromRight, animations: {
            // Toggle visibility after animation completion
            self.verificationView.isHidden.toggle()
            self.resetPasswordView.isHidden.toggle()
        }, completion: nil)
    }
    
    @IBAction func resendBtnPressed(_ sender: UIButton) {
        UIView.transition(with: view, duration: 0.5, options: .transitionFlipFromRight, animations: {
            // Toggle visibility after animation completion
            self.verificationView.isHidden.toggle()
            self.resetPasswordView.isHidden.toggle()
        }, completion: nil)
    }
    
    
    @IBAction func continueBtnPressed(_ sender: UIButton) {
        presenter?.goToCreatenewpasswordVC()
    }
    
    func backBtnPressed() {
        navigationController?.popViewController(animated: true)
    }
}

extension ResetPasswordVC : ResetPasswordVCPrtocol {
    
    func updateUI(){
        resetPasswordView.isHidden = false
        verificationView.isHidden = true
        emailWarningLbl.isHidden = true
    }
    
    func setupInputs(){
        presenter = presenterProducer((
            email: emailAddressTxtFld.rx.text.orEmpty.asDriver(),
            login: nxtBtn.rx.tap.asDriver()
        ))
    }
    
    func setUpBinding(){
        presenter?.output.enableLogin.debug("Enable Login Driver" , trimOutput: false)
            .drive(nxtBtn.rx.isEnabled)
            .disposed(by: bag)
        
        presenter?.output.emailWarning.debug("Enable Login Driver" , trimOutput: false)
            .drive(emailWarningLbl.rx.isHidden)
            .disposed(by: bag)
    }
    
}

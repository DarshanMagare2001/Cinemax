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
    func errorAlert(message:String)
    func successAlert(message:String)
}

class ResetPasswordVC: UIViewController {
    
    @IBOutlet weak var resetPasswordView: UIView!
    @IBOutlet weak var emailAddressTxtFld: UITextField!
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
        resetPasswordRequest()
    }
    
    func backBtnPressed() {
        navigationController?.popViewController(animated: true)
    }
}

extension ResetPasswordVC : ResetPasswordVCPrtocol {
    
    func updateUI(){
        
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
    }
    
    private func resetPasswordRequest(){
        presenter?.resetPasswordRequest(email: emailAddressTxtFld.text)
    }
    
    func errorAlert(message:String){
        Alert.shared.alertOk(title: "Error", message: message, presentingViewController: self) { _ in}
    }
    
    func successAlert(message:String){
        Alert.shared.alertOk(title: "Success", message: message, presentingViewController: self) { _ in
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}

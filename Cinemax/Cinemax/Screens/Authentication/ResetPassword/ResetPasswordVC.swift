//
//  ResetPasswordVC.swift
//  Cinemax
//
//  Created by IPS-161 on 29/01/24.
//

import UIKit

protocol ResetPasswordVCPrtocol: class {
    
}

class ResetPasswordVC: UIViewController {
    
    @IBOutlet weak var resetPasswordView: UIView!
    @IBOutlet weak var verificationView: UIView!
    
    var presenter: ResetPasswordVCPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidload()
        resetPasswordView.isHidden = false
        verificationView.isHidden = true
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
    
}

//
//  ResetPasswordVC.swift
//  Cinemax
//
//  Created by IPS-161 on 29/01/24.
//

import UIKit

class ResetPasswordVC: UIViewController {
    
    @IBOutlet weak var resetPasswordView: UIView!
    @IBOutlet weak var verificationView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetPasswordView.isHidden = false
        verificationView.isHidden = true
    }
    
    
    @IBAction func nxtBtnPressed(_ sender: UIButton) {
        verificationView.isHidden.toggle()
        resetPasswordView.isHidden.toggle()
    }
    
    @IBAction func resendBtnPressed(_ sender: UIButton) {
        verificationView.isHidden.toggle()
        resetPasswordView.isHidden.toggle()
    }
    
    func backBtnPressed(){
        navigationController?.popViewController(animated: true)
    }
    
}

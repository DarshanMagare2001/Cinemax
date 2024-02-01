//
//  ProfileVC.swift
//  Cinemax
//
//  Created by IPS-161 on 01/02/24.
//

import UIKit

protocol ProfileVCProtocol : class {
    func errorAlert(message:String)
}

class ProfileVC: UIViewController {
    
    var presenter : ProfileVCPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidload()
    }
    
    @IBAction func logOutbtnPressed(_ sender: UIButton) {
        confirmBox()
    }
    
}

extension ProfileVC : ProfileVCProtocol {
    
    private func confirmBox(){
        Alert.shared.alertYesNo(title: "Log out!", message: "Are you sure to log out ?.", presentingViewController: self) { [weak self] _ in
            self?.presenter?.currentUserLogout()
        } noHandler: { _ in}
    }
    
    func errorAlert(message:String){
        Alert.shared.alertOk(title: "Error", message: message, presentingViewController: self) { _ in}
    }
    
}

//
//  EditProfileVC.swift
//  Cinemax
//
//  Created by IPS-161 on 02/02/24.
//

import UIKit

protocol EditProfileVCProtocol : class {
    
}

class EditProfileVC: UIViewController {

    var presenter: EditProfileVCPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidload()
    }

    func backBtnPressed(){
        navigationController?.popViewController(animated: true)
    }

}

extension EditProfileVC : EditProfileVCProtocol {
    
}

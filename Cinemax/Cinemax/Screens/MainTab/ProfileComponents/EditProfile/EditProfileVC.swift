//
//  EditProfileVC.swift
//  Cinemax
//
//  Created by IPS-161 on 02/02/24.
//

import UIKit

protocol EditProfileVCProtocol : class {
    func setupUI(name:String,email:String)
}

class EditProfileVC: UIViewController {

    @IBOutlet weak var fullNameTxtFld: UITextField!
    @IBOutlet weak var fullnameWarningLbl: RoundedLabelWithBorder!
    @IBOutlet weak var currentUserName: UILabel!
    @IBOutlet weak var currentUserEmailLbl: UILabel!
    
    var presenter: EditProfileVCPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidload()
    }

    @IBAction func saveBtnPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func profileImgEditBtn(_ sender: UIButton) {
        
    }
    
}

extension EditProfileVC : EditProfileVCProtocol {

    func setupUI(name:String,email:String){
        currentUserName.text = name
        currentUserEmailLbl.text = email
    }
    
    func backBtnPressed(){
        navigationController?.popViewController(animated: true)
    }
    
}

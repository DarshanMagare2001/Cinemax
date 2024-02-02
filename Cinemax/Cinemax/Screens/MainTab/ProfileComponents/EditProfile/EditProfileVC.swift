//
//  EditProfileVC.swift
//  Cinemax
//
//  Created by IPS-161 on 02/02/24.
//

import UIKit
import YPImagePicker

protocol EditProfileVCProtocol : class {
    func setupUI(name:String,email:String)
}

class EditProfileVC: UIViewController {
    
    @IBOutlet weak var fullNameTxtFld: UITextField!
    @IBOutlet weak var fullnameWarningLbl: RoundedLabelWithBorder!
    @IBOutlet weak var currentUserName: UILabel!
    @IBOutlet weak var currentUserEmailLbl: UILabel!
    @IBOutlet weak var currentUserProfileImg: CircleImageView!
    
    var presenter: EditProfileVCPresenterProtocol?
    var config = YPImagePickerConfiguration()
    var imgPicker = YPImagePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidload()
    }
    
    @IBAction func saveBtnPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func profileImgEditBtn(_ sender: UIButton) {
        presentImagePicker()
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
    
    func presentImagePicker() {
        if let topViewController = UIApplication.topViewController() {
            if topViewController.presentedViewController is YPImagePicker {
                return
            }
        }
        imgPicker.didFinishPicking { [weak self] items, cancelled in
            for item in items {
                switch item {
                case .photo(let photo):
                    let image = photo.image
                    self?.currentUserProfileImg.image = image
                    self?.presenter?.saveCurrentUserImgToFirebaseStorageAndDatabase(image: image)
                case .video(let video):
                    break
                }
            }
            self?.dismiss(animated: true, completion: nil)
        }
        present(imgPicker, animated: true, completion: nil)
    }
    
}

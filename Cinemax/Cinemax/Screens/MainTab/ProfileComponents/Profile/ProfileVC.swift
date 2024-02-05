//
//  ProfileVC.swift
//  Cinemax
//
//  Created by IPS-161 on 01/02/24.
//

import UIKit

protocol ProfileVCProtocol : class {
    func errorAlert(message:String)
    func updateUI(name:String ,email: String, profileImgUrl:String)
}

class ProfileVC: UIViewController {
    
    @IBOutlet weak var currentUserName: UILabel!
    @IBOutlet weak var currentUserEmail: UILabel!
    @IBOutlet weak var currentUserProfileImage: CircleImageView!
    
    var presenter : ProfileVCPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidload()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    
    @IBAction func logOutbtnPressed(_ sender: UIButton) {
        confirmBox()
    }
    
    @IBAction func editBtnPressed(_ sender: UIButton) {
        presenter?.goToEditProfileVC()
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
    
    func updateUI(name:String ,email: String, profileImgUrl:String){
        currentUserName.text = name
        currentUserEmail.text = email
        ImageLoader.loadImage(imageView: currentUserProfileImage, imageUrl: profileImgUrl, placeHolderType: .systemName, placeHolderImage: "person.fill")
    }
    
}

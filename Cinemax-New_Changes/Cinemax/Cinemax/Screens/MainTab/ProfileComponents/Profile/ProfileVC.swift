//
//  ProfileVC.swift
//  Cinemax
//
//  Created by IPS-161 on 01/02/24.
//

import UIKit
import RxSwift

protocol ProfileVCProtocol : class {
    func errorAlert(message:String)
    func bindUI()
}

class ProfileVC: UIViewController {
    
    @IBOutlet weak var currentUserName: UILabel!
    @IBOutlet weak var currentUserEmail: UILabel!
    @IBOutlet weak var currentUserProfileImage: CircleImageView!
    
    var presenter : ProfileVCPresenterProtocol?
    var userDataRepositoryManager: UserDataRepositoryManagerProtocol?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userDataRepositoryManager = UserDataRepositoryManager.shared
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
    
    func bindUI(){
        userDataRepositoryManager?.userName.subscribe { event in
            if let element = event.element {
                DispatchQueue.main.async { [weak self] in
                    self?.currentUserName.text = element
                }
            }
        }.disposed(by: disposeBag)
        
        userDataRepositoryManager?.userProfileImageUrl.subscribe{ event in
            if let element = event.element {
                DispatchQueue.main.async { [weak self] in
                    self?.currentUserProfileImage.loadImage(urlString: element, placeholder: "person.fill")
                }
            }
        }.disposed(by: disposeBag)
        
        
        userDataRepositoryManager?.userEmailAddress.subscribe{ event in
            if let element = event.element {
                DispatchQueue.main.async { [weak self] in
                    self?.currentUserEmail.text = element
                }
            }
        }.disposed(by: disposeBag)
    }
    
}

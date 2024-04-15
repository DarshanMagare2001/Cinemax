//
//  EditProfileVC.swift
//  Cinemax
//
//  Created by IPS-161 on 02/02/24.
//

import UIKit
import YPImagePicker
import SwiftUI
import RxSwift

protocol EditProfileVCProtocol : class {
    func setupInputs()
    func setupWarningLbls()
    func setUpBinding()
    func errorMsgAlert(error:String)
}

class EditProfileVC: UIViewController {
    
    @IBOutlet weak var fullNameTxtFld: UITextField!
    @IBOutlet weak var fullnameWarningLbl: RoundedLabelWithBorder!
    @IBOutlet weak var currentUserName: UILabel!
    @IBOutlet weak var currentUserEmailLbl: UILabel!
    @IBOutlet weak var currentUserProfileImg: CircleImageView!
    @IBOutlet weak var saveChangesBtn: RoundedButton!
    
    var presenter : EditProfileVCPresenterProtocol?
    var userDataRepositoryManager: UserDataRepositoryManagerProtocol?
    var presenterProducer : EditProfileVCPresenterProtocol.Producer!
    var config = YPImagePickerConfiguration()
    var imgPicker = YPImagePicker()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userDataRepositoryManager = UserDataRepositoryManager.shared
        setupInputs()
        presenter?.viewDidload()
    }
    
    @IBAction func saveBtnPressed(_ sender: UIButton) {
        presenter?.updateCurrentuseerNameInDatabase(name: fullNameTxtFld.text){ [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func profileImgEditBtn(_ sender: UIButton) {
        presentImagePicker()
    }
    
}

extension EditProfileVC : EditProfileVCProtocol {
    
    func setupWarningLbls(){
        fullnameWarningLbl.isHidden = true
    }
    
    func setupInputs(){
        presenter = presenterProducer((
            fullName: fullNameTxtFld.rx.text.orEmpty.asDriver(),
            login: saveChangesBtn.rx.tap.asDriver()
        ))
    }
    
    func setUpBinding(){
        presenter?.output.enableLogin.debug("Enable Login Driver" , trimOutput: false)
            .drive(saveChangesBtn.rx.isEnabled)
            .disposed(by: disposeBag)
        
        presenter?.output.fullNameWarning.debug("Enable Login Driver" , trimOutput: false)
            .drive(fullnameWarningLbl.rx.isHidden)
            .disposed(by: disposeBag)
        
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
                    self?.currentUserProfileImg.loadImage(urlString: element, placeholder: "person.fill")
                }
            }
        }.disposed(by: disposeBag)
        
        
        userDataRepositoryManager?.userEmailAddress.subscribe{ event in
            if let element = event.element {
                DispatchQueue.main.async { [weak self] in
                    self?.currentUserEmailLbl.text = element
                }
            }
        }.disposed(by: disposeBag)
        
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
    
    func errorMsgAlert(error:String){
        Alert.shared.alertOk(title: "Error!", message: error, presentingViewController: self) { _ in}
    }
    
}

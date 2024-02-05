//
//  EditProfileVCPresenter.swift
//  Cinemax
//
//  Created by IPS-161 on 02/02/24.
//

import Foundation
import UIKit

protocol EditProfileVCPresenterProtocol {
    func viewDidload()
    func saveCurrentUserImgToFirebaseStorageAndDatabase(image: UIImage)
    func updateCurrentuseerNameInDatabase(name: String?,completion:@escaping()->())
}

class EditProfileVCPresenter {
    weak var view: EditProfileVCProtocol?
    var interactor: EditProfileVCInteractorProtocol
    init(view: EditProfileVCProtocol,interactor: EditProfileVCInteractorProtocol){
        self.view = view
        self.interactor = interactor
    }
}

extension EditProfileVCPresenter: EditProfileVCPresenterProtocol {
    func viewDidload(){
        DispatchQueue.main.async { [weak self] in
            self?.setupUI()
        }
    }
    
    private func setupUI(){
        if let name = UserdefaultRepositoryManager.fetchUserInfoFromUserdefault(type: .currentUsersName),
           let email = UserdefaultRepositoryManager.fetchUserInfoFromUserdefault(type: .currentUsersEmail){
            self.view?.setupUI(name: name, email: email)
        }
    }
    
    func saveCurrentUserImgToFirebaseStorageAndDatabase(image: UIImage){
        DispatchQueue.main.async { [weak self] in
            Loader.shared.showLoader(type: .lineScale, color: .white)
        }
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.interactor.saveCurrentUserImgToFirebaseStorageAndDatabase(image: image) { result in
                switch result{
                case.success(let bool):
                    print(bool)
                    DispatchQueue.main.async { [weak self] in
                        Loader.shared.hideLoader()
                    }
                case.failure(let error):
                    print(error)
                    DispatchQueue.main.async { [weak self] in
                        Loader.shared.hideLoader()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now()+1){  [weak self] in
                        self?.view?.errorMsgAlert(error: error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func updateCurrentuseerNameInDatabase(name: String?,completion:@escaping()->()){
        DispatchQueue.main.async { [weak self] in
            Loader.shared.showLoader(type: .lineScale, color: .white)
        }
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.interactor.updateCurrentuseerNameInDatabase(name: name) { result in
                switch result{
                case .success(let bool):
                    print(bool)
                    DispatchQueue.main.async { [weak self] in
                        Loader.shared.hideLoader()
                        completion()
                    }
                case.failure(let error):
                    print(error)
                    DispatchQueue.main.async { [weak self] in
                        Loader.shared.hideLoader()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now()+1){  [weak self] in
                        self?.view?.errorMsgAlert(error: error.localizedDescription)
                    }
                }
            }
        }
    }
    
    
}


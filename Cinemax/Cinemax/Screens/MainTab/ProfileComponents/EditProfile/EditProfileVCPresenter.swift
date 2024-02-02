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
        interactor.saveCurrentUserImgToFirebaseStorageAndDatabase(image: image) { result in
            switch result{
            case.success(let bool):
                print(bool)
            case.failure(let error):
                print(error)
            }
        }
    }
}


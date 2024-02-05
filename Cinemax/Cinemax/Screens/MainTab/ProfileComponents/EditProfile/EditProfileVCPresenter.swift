//
//  EditProfileVCPresenter.swift
//  Cinemax
//
//  Created by IPS-161 on 02/02/24.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

protocol EditProfileVCPresenterProtocol {
    func viewDidload()
    func saveCurrentUserImgToFirebaseStorageAndDatabase(image: UIImage)
    func updateCurrentuseerNameInDatabase(name: String?,completion:@escaping()->())
    
    typealias Input = (
        fullName : Driver<String>,
        login:Driver<Void>
    )
    
    typealias Output = (
        enableLogin : Driver<Bool>,
        fullNameWarning: Driver<Bool>
    )
    
    typealias Producer = (EditProfileVCPresenterProtocol.Input) -> EditProfileVCPresenterProtocol
    
    var input : Input { get }
    var output : Output { get }
    
}

class EditProfileVCPresenter {
    weak var view: EditProfileVCProtocol?
    var interactor: EditProfileVCInteractorProtocol
    var input:Input
    var output:Output
    init(view: EditProfileVCProtocol,interactor: EditProfileVCInteractorProtocol,input:Input){
        self.view = view
        self.interactor = interactor
        self.input = input
        self.output = EditProfileVCPresenter.output(input: input)
    }
}

extension EditProfileVCPresenter: EditProfileVCPresenterProtocol {
    func viewDidload(){
        DispatchQueue.main.async { [weak self] in
            self?.view?.setUpBinding()
            self?.view?.setupWarningLbls()
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

private extension EditProfileVCPresenter {
    
    static func output(input:Input) -> Output {
        let enableLoginDriver =  input.fullName.map { !$0.isEmpty }
        let fullNameWarningDriver = input.fullName.map { !$0.isEmpty }
        return (
            enableLogin : enableLoginDriver,
            fullNameWarning: fullNameWarningDriver
        )
    }
    
}

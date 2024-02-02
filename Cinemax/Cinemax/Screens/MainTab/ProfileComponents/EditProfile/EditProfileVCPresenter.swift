//
//  EditProfileVCPresenter.swift
//  Cinemax
//
//  Created by IPS-161 on 02/02/24.
//

import Foundation

protocol EditProfileVCPresenterProtocol {
    func viewDidload()
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
        
    }
}


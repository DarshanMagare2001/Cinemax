//
//  EditProfileVCInteractor.swift
//  Cinemax
//
//  Created by IPS-161 on 02/02/24.
//

import Foundation
import UIKit

protocol EditProfileVCInteractorProtocol {
    func saveCurrentUserImgToFirebaseStorageAndDatabase(image: UIImage,completion:@escaping(Result<Bool,Error>)->())
}

class EditProfileVCInteractor {
    
}

extension EditProfileVCInteractor: EditProfileVCInteractorProtocol {
    
    func saveCurrentUserImgToFirebaseStorageAndDatabase(image: UIImage,completion:@escaping(Result<Bool,Error>)->()){
        StoreUserServerManager.shared.saveCurrentUserImageToFirebaseStorage(image: image) { result in
            switch result {
            case.success(let url):
                let profileUrl = url.absoluteString
                self.saveImgUrlToDatabase(url: profileUrl){ urlData in
                    switch urlData {
                    case.success(let bool):
                        completion(.success(bool))
                    case.failure(let error):
                        completion(.failure(error))
                    }
                }
            case.failure(let error):
                print(error)
            }
        }
    }
    
    private func saveImgUrlToDatabase(url:String,completion:@escaping(Result<Bool,Error>)->()){
        StoreUserServerManager.shared.saveCurrentUserImageToFirebaseDatabase(url: url) { result in
            completion(result)
        }
    }
    
}

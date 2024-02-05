//
//  LoginVCInteractor.swift
//  Cinemax
//
//  Created by IPS-161 on 29/01/24.
//

import Foundation
import FirebaseAuth

protocol LoginVCInteractorProtocol {
    func signIn(email: String?, password: String?, completion: @escaping (Result<Bool,AuthenticationError>) -> Void)
    func fetchCurrentUserFromFirebase(completion: @escaping (Result<UserServerModel?, Error>) -> Void)
    func saveUsersDataToUserdefault(user:UserServerModel?)
}

class LoginVCInteractor {
    
}

extension LoginVCInteractor: LoginVCInteractorProtocol {
    
    func signIn(email: String?, password: String?, completion: @escaping (Result<Bool,AuthenticationError>) -> Void){
        guard let email = email , let password = password else {
            return completion(.failure(AuthenticationError.invalidCredentials))
        }
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                // Handle sign-in error
                print("Sign-in error: \(error.localizedDescription)")
                completion(.failure(AuthenticationError.serverError(error)))
                return
            }
            print("Sign-in successful with email: \(email)")
            completion(.success(true))
        }
    }
    
    func fetchCurrentUserFromFirebase(completion: @escaping (Result<UserServerModel?, Error>) -> Void){
        FetchUserServerManager.shared.fetchCurrentUserFromFirebase { result in
            completion(result)
        }
    }
    
    func saveUsersDataToUserdefault(user:UserServerModel?){
        guard let user = user , let name = user.name , let email = user.email , let currentUid = user.uid , let currentUsersProfileImageUrl = user.profileImgUrl else {
            return
        }
        UserdefaultRepositoryManager.storeUserInfoFromUserdefault(type: .currentUsersName, data: name) { _ in}
        UserdefaultRepositoryManager.storeUserInfoFromUserdefault(type: .currentUsersEmail, data: email) { _ in}
        UserdefaultRepositoryManager.storeUserInfoFromUserdefault(type: .currentUsersUid, data: currentUid) { _ in}
        UserdefaultRepositoryManager.storeUserInfoFromUserdefault(type: .currentUsersProfileImageUrl, data: currentUsersProfileImageUrl) { _ in}
    }
    
    
}

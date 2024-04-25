//
//  SignUpVCInteractor.swift
//  Cinemax
//
//  Created by IPS-161 on 29/01/24.
//

import Foundation
import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

protocol SignUpVCInteractorProtocol {
    func signinWithGoogle(view: UIViewController , completion:@escaping(Result<Bool,Error>)->())
    func getGoogleUserProfile(completion: @escaping () -> ())
}

class SignUpVCInteractor {
    var userDataRepositoryManager : UserDataRepositoryManagerProtocol?
    init(userDataRepositoryManager : UserDataRepositoryManagerProtocol){
        self.userDataRepositoryManager = userDataRepositoryManager
    }
}

extension SignUpVCInteractor: SignUpVCInteractorProtocol {
    
    func signinWithGoogle(view: UIViewController , completion:@escaping(Result<Bool,Error>)->()){
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: view) { [weak self] result, error in
            print(error)
            guard error == nil else {
                completion(.failure(error as! Error))
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                return            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            Auth.auth().signIn(with: credential) { result, error in
                guard error == nil else {
                    completion(.failure(error as! Error))
                    return
                }
                completion(.success(true))
            }
            
        }
    }
    
    func getGoogleUserProfile(completion: @escaping () -> ()) {
        guard let currentUser = GIDSignIn.sharedInstance.currentUser else {
            completion()
            return
        }
        var user = UserServerModel(
            uid: currentUser.userID ?? "",
            firstName: currentUser.profile?.givenName ?? "",
            lastName: currentUser.profile?.familyName ?? "",
            phoneNumber: "",
            gender: "",
            dateOfBirth: "",
            email: currentUser.profile?.email ?? "",
            profileImgUrl: currentUser.profile?.imageURL(withDimension: 300)?.absoluteString ?? ""
        )
        saveUsersDataToUserdefault(user:user)
        completion()
    }
    
    func saveUsersDataToUserdefault(user:UserServerModel){
        guard let firstName = user.firstName,
              let lastName = user.lastName,
              let phoneNumber = user.phoneNumber,
              let gender = user.gender,
              let email = user.email,
              let dateOfBirth = user.dateOfBirth,
              let profileImageUrl = user.profileImgUrl,
              let currentUid = Auth.auth().currentUser?.uid else {
            return
        }
        UserdefaultRepositoryManager.storeUserInfoFromUserdefault(type: .currentUsersFirstName, data: firstName) { _ in}
        UserdefaultRepositoryManager.storeUserInfoFromUserdefault(type: .currentUsersLastName, data: lastName) { _ in}
        UserdefaultRepositoryManager.storeUserInfoFromUserdefault(type: .currentUsersPhoneNumber, data: phoneNumber) { _ in}
        UserdefaultRepositoryManager.storeUserInfoFromUserdefault(type: .currentUsersGender, data: gender) { _ in}
        UserdefaultRepositoryManager.storeUserInfoFromUserdefault(type: .currentUsersDateOfBirth, data: dateOfBirth) { _ in}
        UserdefaultRepositoryManager.storeUserInfoFromUserdefault(type: .currentUsersEmail, data: email) { _ in}
        UserdefaultRepositoryManager.storeUserInfoFromUserdefault(type: .currentUsersUid, data: currentUid) { _ in}
        UserdefaultRepositoryManager.storeUserInfoFromUserdefault(type: .currentUsersProfileImageUrl, data: profileImageUrl) { _ in}
        userDataRepositoryManager?.userFirstName.onNext(firstName)
        userDataRepositoryManager?.userEmailAddress.onNext(email)
        userDataRepositoryManager?.userProfileImageUrl.onNext(profileImageUrl)
    }
    
}


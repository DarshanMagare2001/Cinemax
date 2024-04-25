//
//  UserDataRepositoryManager.swift
//  Cinemax
//
//  Created by IPS-177  on 15/04/24.
//

import Foundation
import RxSwift
import UIKit

protocol UserDataRepositoryManagerProtocol {
    var userFirstName: BehaviorSubject<String> { get set }
    var userProfileImageUrl: BehaviorSubject<String> { get set }
    var userEmailAddress: BehaviorSubject<String> { get set }
}

class UserDataRepositoryManager {
    static let shared = UserDataRepositoryManager()
    var userFirstName = BehaviorSubject(value:"")
    var userProfileImageUrl = BehaviorSubject(value:"")
    var userEmailAddress = BehaviorSubject(value:"")
    init(){
        updateUserData()
    }
}

extension UserDataRepositoryManager: UserDataRepositoryManagerProtocol {
    func updateUserData(){
        if let userFirstName = UserdefaultRepositoryManager.fetchUserInfoFromUserdefault(type: .currentUsersFirstName){
            self.userFirstName.onNext(userFirstName)
        }
        if let userProfileImageUrl = UserdefaultRepositoryManager.fetchUserInfoFromUserdefault(type: .currentUsersProfileImageUrl){
            self.userProfileImageUrl.onNext(userProfileImageUrl)
        }
        if let userEmailAddress = UserdefaultRepositoryManager.fetchUserInfoFromUserdefault(type: .currentUsersEmail){
            self.userEmailAddress.onNext(userEmailAddress)
        }
    }
}

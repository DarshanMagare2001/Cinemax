//
//  UserdefaultRepositoryManager.swift
//  Cinemax
//
//  Created by IPS-161 on 25/01/24.
//

import Foundation

public final class UserdefaultRepositoryManager {
    enum UserInfoFromUserdefault: String {
        case isOnboardingDone = "isOnboardingDone"
    }
    
    static func fetchUserInfoFromUserdefault(type: UserInfoFromUserdefault) -> String? {
        let semaphore = DispatchSemaphore(value: 0)
        var result: String?
        UserdefaultRepository.shared.getData(key: type.rawValue) { (dataResult: Result<String?, Error>) in
            switch dataResult {
            case .success(let data):
                result = data
            case .failure(let error):
                print(error)
            }
            semaphore.signal()
        }
        semaphore.wait()
        return result
    }
    
    static func storeUserInfoFromUserdefault<T>(type: UserInfoFromUserdefault , data: T?) -> Bool? {
        let semaphore = DispatchSemaphore(value: 0)
        var result: Bool?
        if let data = data {
            UserdefaultRepository.shared.saveData(data, key: type.rawValue) { bool in
                result = bool
                semaphore.signal()
            }
        }
        semaphore.wait()
        return result
    }
    
}

//
//  StoreUserServerManager.swift
//  Cinemax
//
//  Created by IPS-161 on 01/02/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

typealias EscapingResultBoolErrorClosure = (Result<Bool, Error>)->()

public final class StoreUserServerManager {
    static let shared = StoreUserServerManager()
    private init(){}
    
    // MARK: - storeCurrentUserNameAndEmailToServer
    
    func storeCurrentUserDataToServer(name: String?, email: String?, completion: @escaping EscapingResultBoolErrorClosure) {
        guard let currentUserId = Auth.auth().currentUser?.uid, let name = name, let email = email else {
            completion(.failure(NSError(domain: "CINEMAX", code: 0, userInfo: [NSLocalizedDescriptionKey: "User not logged in"])))
            return
        }
        
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(currentUserId)
        // Create a dictionary with both the uid and fcmToken
        let data: [String: Any] = ["uid": currentUserId,
                                   "name": name,
                                   "email": email]
        // Set the document with the combined data
        userRef.setData(data, merge: true) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
        
    }
    
}

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
    
}

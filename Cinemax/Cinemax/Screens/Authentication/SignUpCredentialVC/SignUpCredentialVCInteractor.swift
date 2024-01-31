//
//  SignUpCredentialVCInteractor.swift
//  Cinemax
//
//  Created by IPS-161 on 29/01/24.
//

import Foundation
import FirebaseAuth

enum AuthenticationError : Error {
    case invalidCredentials
    case serverError(Error)
}


protocol SignUpCredentialVCInteractorProtocol {
    func signUp(email: String?, password: String?, completion: @escaping (Result<Bool,AuthenticationError>) -> Void)
}

class SignUpCredentialVCInteractor {
    
}

extension SignUpCredentialVCInteractor: SignUpCredentialVCInteractorProtocol {
    
    func signUp(email: String?, password: String?, completion: @escaping (Result<Bool,AuthenticationError>) -> Void){
        guard let email = email , let password = password else {
            return completion(.failure(AuthenticationError.invalidCredentials))
        }
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                // Handle sign-up error
                print("Sign-up error: \(error.localizedDescription)")
                completion(.failure(AuthenticationError.serverError(error)))
                return
            }
            print("Sign-up successful with email: \(email)")
            completion(.success(true))
        }
    }
    
}

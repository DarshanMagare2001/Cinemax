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
}

class SignUpVCInteractor {
    
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
    
}


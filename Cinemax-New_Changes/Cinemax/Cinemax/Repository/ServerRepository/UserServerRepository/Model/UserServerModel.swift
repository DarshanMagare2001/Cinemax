//
//  UserServerModel.swift
//  Cinemax
//
//  Created by IPS-161 on 01/02/24.
//

import Foundation

struct UserServerModel {
    var uid:String?
    var name: String?
    var email: String?
    var profileImgUrl: String?
    init(uid:String,name: String,email: String,profileImgUrl: String){
        self.uid = uid
        self.name = name
        self.email = email
        self.profileImgUrl = profileImgUrl
    }
}

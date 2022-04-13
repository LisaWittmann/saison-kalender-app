//
//  UserFormModel.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 13.04.22.
//

import Foundation

struct LoginModel {
    var name: String = ""
    var password: String = ""
}

struct RegisterModel {
    var name: String = ""
    var email: String = ""
    var password: String = ""
    var passwordRepeat: String = ""
}

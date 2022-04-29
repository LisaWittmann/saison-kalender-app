//
//  UserFormModel.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 13.04.22.
//

import Foundation

struct UserFormModel {
    var name: String = ""
    var email: String = ""
    var password: String = ""
    var passwordRepeat: String = ""
    
    func isValidName(_ name: String) -> Bool {
        let nameFormat = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameFormat)
        return namePredicate.evaluate(with: name)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let name = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
        let domain = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
        let emailFormat = name + "@" + domain + "[A-Za-z]{2,8}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let passwordFormat = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[$@$#!%*?&]).{8,}"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordFormat)
        return passwordPredicate.evaluate(with: password)
    }
    
    func isValidPasswordRepeat(_ passwordRepeat: String) -> Bool {
        return password == passwordRepeat
    }
    
    func isValidForLogin() -> Bool {
        return (name != "") && (password != "")
    }
    
    func isValidForRegister() -> Bool {
        return isValidName(name) &&
            isValidEmail(email) &&
            isValidPassword(password) &&
            isValidPasswordRepeat(passwordRepeat)
    }
}

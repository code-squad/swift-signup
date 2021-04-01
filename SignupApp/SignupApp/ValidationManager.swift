//
//  ValidationManager.swift
//  SignupApp
//
//  Created by Song on 2021/03/31.
//

import Foundation

struct ValidationManager {
    func isAvailable(username: String) -> Bool {
        return username.validate(with: K.Regex.username)
    }
    
    func isSatisfiedLength(password: String) -> Bool {
        return password.validate(with: K.Regex.passwordLength)
    }
    
    func hasUppercase(password: String) -> Bool {
        return password.validate(with: K.Regex.passwordUppercase)
    }
    
    func hasDigit(password: String) -> Bool {
        return password.validate(with: K.Regex.passwordDigit)
    }
    
    func hasSpecialCharacter(password: String) -> Bool {
        return password.validate(with: K.Regex.passwordSpecialCharacter)
    }
    
    func isAvailable(password: String) -> Bool {
        return password.validate(with: K.Regex.password)
    }
}

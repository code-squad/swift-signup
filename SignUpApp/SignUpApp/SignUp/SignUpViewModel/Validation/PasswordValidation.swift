//
//  PasswordValidation.swift
//  SignUpApp
//
//  Created by Jun Ho JANG on 2021/04/05.
//

import Foundation

class PasswordValidation {
    
    private func returnValidation(input: String) -> Bool {
        if isCharNumValid(input: input) == true && isUpperCharacterIncludedPassword(input: input) == true && isNumberIncludedPassword(input: input) == true && isSpecialCharacterIncludedPassword(input: input) == true {
            return true
        } else {
            return false
        }
    }
    
    private func checkPassword(input: String) -> String {
        if isCharNumValid(input: input) == false {
            return PasswordCheckMessage.characterNumberWarning.rawValue
        } else if isUpperCharacterIncludedPassword(input: input) == false {
            return PasswordCheckMessage.charcterUpperWarning.rawValue
        } else if isNumberIncludedPassword(input: input) == false {
            return PasswordCheckMessage.numberIncludedWarning.rawValue
        } else if isSpecialCharacterIncludedPassword(input: input) == false {
            return PasswordCheckMessage.specialCharacterWarning.rawValue
        }
        return PasswordCheckMessage.validatedCaseMessage.rawValue
    }
    
    private func isCharNumValid(input: String) -> Bool {
        if input.count > 16 || input.count < 8 {
            return false
        } else {
            return true
        }
    }
    
    private func isUpperCharacterIncludedPassword(input: String) -> Bool {
        let passwordRegEx = "^(?=.*[A-Z]).{8,16}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: input)
    }
    
    private func isNumberIncludedPassword(input: String) -> Bool {
        let passwordRegEx = "^(?=.*[0-9]).{8,16}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: input)
    }
    
    private func isSpecialCharacterIncludedPassword(input: String) -> Bool {
        let passwordRegEx = "^(?=.*[!@#$%]).{8,16}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: input)
    }
    
    func returnValidationResult(input: String) -> Bool {
        return returnValidation(input: input)
    }
    
    func checkPasswordResult(input: String) -> String {
        return checkPassword(input: input)
    }
    
}

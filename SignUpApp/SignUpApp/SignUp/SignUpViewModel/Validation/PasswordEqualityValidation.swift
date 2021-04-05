//
//  PasswordEqualityValidation.swift
//  SignUpApp
//
//  Created by Jun Ho JANG on 2021/04/05.
//

import Foundation

class PasswordEqualityValidation {
    
    private func returnValidation(input: String, secondInput: String) -> Bool {
        if isEqual(input: input, secondInput: secondInput) == true {
            return true
        } else {
            return false
        }
    }
    
    private func checkEquality(input: String, secondInput: String) -> String {
        if isEqual(input: input, secondInput: secondInput) == false {
            return PasswordEqualityMessage.notEqualPasswordWarning.rawValue
        } else {
            return PasswordEqualityMessage.validatedCaseMessage.rawValue
        }
    }
    
    private func isEqual(input: String, secondInput: String) -> Bool {
        if input != secondInput {
            return false
        } else {
            return true
        }
    }
    
    func returnValidationResult(input: String, secondInput: String) -> Bool {
        return returnValidation(input: input, secondInput: secondInput)
    }
    
    func checkEqualityResult(input: String, secondInput: String) -> String {
        return checkEquality(input: input, secondInput: secondInput)
    }
    
}

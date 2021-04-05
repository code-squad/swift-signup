//
//  UserNameValidation.swift
//  SignUpApp
//
//  Created by Jun Ho JANG on 2021/04/05.
//

import Foundation

class UserNameValidation {
    
    private func returnValidation(input: String) -> Bool {
        if isInput(input: input) == true {
            return true
        } else {
            return false
        }
    }
    
    private func checkUserNameInput(input: String) -> String {
        if isInput(input: input) == false {
            return UserNameCheckMessage.notInputWarning.rawValue
        } else {
            return UserNameCheckMessage.validatedCaseMessage.rawValue
        }
    }
    
    private func isInput(input: String) -> Bool {
        if input.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    func returnValidationResult(input: String) -> Bool {
        return returnValidation(input: input)
    }
    
    func checkUserNameResult(input: String) -> String {
        return checkUserNameInput(input: input)
    }
    
}

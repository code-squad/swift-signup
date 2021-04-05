//
//  IDValidation.swift
//  SignUpApp
//
//  Created by Jun Ho JANG on 2021/04/05.
//

import Foundation

class IDValidation {
    
    private var idList = [String]()
    
    init() {
        NetworkingForIDCheck.getData { serverIdList in
            self.idList = serverIdList
        }
    }
    
    private func returnValidation(input: String) -> Bool {
        if isValidCharacterID(input: input) == true && isUnique(input: input) == true  {
            return true
        } else {
            return false
        }
    }
    
    private func checkID(input: String) -> String {
        if isUnique(input: input) == false {
            return IDCheckMessage.usedIDWarning.rawValue
        } else if isValidCharacterID(input: input) == false {
            return IDCheckMessage.charcterWarning.rawValue
        } else {
            return IDCheckMessage.validatedCaseMessage.rawValue
        }
    }
    
    private func isValidCharacterID(input: String) -> Bool {
        let passwordRegEx = "^(?=.*[a-z0-9_-]).{5,20}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: input)
    }
    
    private func isUnique(input: String) -> Bool {
        if idList.contains(input) {
            return false
        } else {
            return true
        }
    }
    
    func returnValidationResult(input: String) -> Bool {
        return returnValidation(input: input)
    }
    
    func checkIDResult(input: String) -> String {
        return checkID(input: input)
    }

}

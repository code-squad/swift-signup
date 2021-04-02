//
//  PasswordChecker.swift
//  SignUp
//
//  Created by 양준혁 on 2021/04/01.
//

import Foundation

class PasswordChecker {
    
    private var state: PasswordState?
    
    func check(text: String, completion: @escaping (PasswordState)->Void) {
        let extract = text.getArrayAfterRegex(regex: "[0-9a-zA-Z~!@#$%^&*()_+|]+")
        if extract.isEmpty || (extract[0] != text) {
            return
        }
        if text.getArrayAfterRegex(regex: "[~!@#$%^&*()_+|]+").isEmpty {
            state = PasswordState.notIncludeSpecialCharacter
            completion(state!)
        } else if text.count < 8 || text.count > 16 {
            state = PasswordState.incorrectPWCount
            completion(state!)
        } else if text.getArrayAfterRegex(regex: "[A-Z]+").isEmpty {
            state = PasswordState.notIncludeUpperCase
            completion(state!)
        } else if text.getArrayAfterRegex(regex: "[0-9]+").isEmpty {
            state = PasswordState.notIncludeNumber
            completion(state!)
        } else if !text.getArrayAfterRegex(regex: "[0-9a-zA-Z~!@#$%^&*()_+|]+")[0].isEmpty {
            state = PasswordState.correct
            completion(state!)
        }
    }
}

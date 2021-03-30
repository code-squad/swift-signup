//
//  PWTextFieldDelegate.swift
//  SignUp
//
//  Created by 양준혁 on 2021/03/29.
//

import UIKit

class PWTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    private var state: PasswordTextFieldState? = nil
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        let text = textField.text ?? ""
        let extract = text.getArrayAfterRegex(regex: "[0-9a-zA-Z~!@#$%^&*()_+|]+")
        if text == "" || extract == [] {
            state = PasswordTextFieldState.incorrect
            return true
        }
        if text.getArrayAfterRegex(regex: "[0-9a-zA-Z]+")[0] == text {
            textField.layer.borderWidth = 1.0
            textField.layer.borderColor = #colorLiteral(red: 0.9967475533, green: 0.03828956559, blue: 0.05758263916, alpha: 1)
            state = PasswordTextFieldState.notIncludeSpecialCharacter
        } else if text.count < 8 && text.count < 16 {
            textField.layer.borderWidth = 1.0
            textField.layer.borderColor = #colorLiteral(red: 0.9967475533, green: 0.03828956559, blue: 0.05758263916, alpha: 1)
            state = PasswordTextFieldState.incorrectPWCount
        } else if text.getArrayAfterRegex(regex: "[0-9a-z~!@#$%^&*()_+|]+")[0] == text {
            textField.layer.borderWidth = 1.0
            textField.layer.borderColor = #colorLiteral(red: 0.9967475533, green: 0.03828956559, blue: 0.05758263916, alpha: 1)
            state = PasswordTextFieldState.notIncludeUpperCase
        } else if text.getArrayAfterRegex(regex: "[a-zA-Z~!@#$%^&*()_+|]+")[0] == text {
            textField.layer.borderWidth = 1.0
            textField.layer.borderColor = #colorLiteral(red: 0.9967475533, green: 0.03828956559, blue: 0.05758263916, alpha: 1)
            state = PasswordTextFieldState.notIncludeNumber
        } else if text.getArrayAfterRegex(regex: "[0-9a-zA-Z~!@#$%^&*()_+|]+")[0] == text {
            textField.layer.borderWidth = 1.0
            textField.layer.borderColor = #colorLiteral(red: 0.1540483236, green: 0.6966413856, blue: 0.1375852525, alpha: 1)
            state = PasswordTextFieldState.correct
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "password"), object: state)
        return true
    }
}

enum PasswordTextFieldState {
    case notIncludeNumber
    case notIncludeUpperCase
    case incorrectPWCount
    case notIncludeSpecialCharacter
    case correct
    case incorrect
}

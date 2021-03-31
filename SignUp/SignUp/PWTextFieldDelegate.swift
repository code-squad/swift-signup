//
//  PWTextFieldDelegate.swift
//  SignUp
//
//  Created by 양준혁 on 2021/03/29.
//

import UIKit

class PWTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    private var state: PasswordState? = nil
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.blue.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        let extract = text.getArrayAfterRegex(regex: "[0-9a-zA-Z~!@#$%^&*()_+|]+")[0]
        if text.getArrayAfterRegex(regex: "[0-9a-zA-Z]+")[0] == extract {
            textField.layer.borderColor = #colorLiteral(red: 0.9967475533, green: 0.03828956559, blue: 0.05758263916, alpha: 1)
            state = PasswordState.notIncludeSpecialCharacter
        } else if text.count < 8 || text.count > 16 {
            textField.layer.borderColor = #colorLiteral(red: 0.9967475533, green: 0.03828956559, blue: 0.05758263916, alpha: 1)
            state = PasswordState.incorrectPWCount
        } else if text.getArrayAfterRegex(regex: "[0-9a-z~!@#$%^&*()_+|]+")[0] == extract {
            textField.layer.borderColor = #colorLiteral(red: 0.9967475533, green: 0.03828956559, blue: 0.05758263916, alpha: 1)
            state = PasswordState.notIncludeUpperCase
        } else if text.getArrayAfterRegex(regex: "[a-zA-Z~!@#$%^&*()_+|]+")[0] == extract {
            textField.layer.borderColor = #colorLiteral(red: 0.9967475533, green: 0.03828956559, blue: 0.05758263916, alpha: 1)
            state = PasswordState.notIncludeNumber
        } else if text.getArrayAfterRegex(regex: "[0-9a-zA-Z~!@#$%^&*()_+|]+")[0] == extract {
            textField.layer.borderColor = #colorLiteral(red: 0.1540483236, green: 0.6966413856, blue: 0.1375852525, alpha: 1)
            state = PasswordState.correct
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "password"), object: state)
    }
}

enum PasswordState {
    case notIncludeNumber
    case notIncludeUpperCase
    case incorrectPWCount
    case notIncludeSpecialCharacter
    case correct
    case incorrect
}

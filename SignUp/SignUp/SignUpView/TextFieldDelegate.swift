//
//  TextFieldDelegate.swift
//  SignUp
//
//  Created by 이다훈 on 2021/03/29.
//

import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.accessibilityIdentifier ?? "" {
        case "PWTextField":
            NotificationCenter.default.post(name: .pwTextField, object: textField)
        case "PW2TextField":
            NotificationCenter.default.post(name: .pw2TextField, object: textField)
        case "IDTextField":
            NotificationCenter.default.post(name: .idTextField, object: textField)
        case "NameTextField":
            NotificationCenter.default.post(name: .nameTextField, object: textField)
        default:
            return
        }
    }
}

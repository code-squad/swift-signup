//
//  IDTextFieldDelegate.swift
//  SignUp
//
//  Created by 양준혁 on 2021/03/29.
//

import UIKit

class IDTextFieldDelegate: NSObject, UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.blue.cgColor
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        let text = textField.text ?? ""
        let extract = text.getArrayAfterRegex(regex: "[0-9a-z_-]+")
        if extract[0] == textField.text && text.count > 4 && text.count < 21 {
            textField.layer.borderWidth = 1.0
            textField.layer.borderColor = UIColor.green.cgColor
        } else {
            textField.layer.borderWidth = 1.0
            textField.layer.borderColor = UIColor.red.cgColor
        }
        return true
    }
}



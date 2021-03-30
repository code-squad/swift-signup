//
//  PasswordConfirmFieldDelegate.swift
//  SignUp
//
//  Created by Ador on 2021/03/30.
//

import UIKit

class PasswordConfirmFieldDelegate: NSObject, UITextFieldDelegate {
    var passwordConfirmHandler: (() -> Bool)?
    var updateLabelHandler: (((PasswordCheck, UIColor)) -> Void)?
    var firstResponserHandler: (() -> Void)?
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 0
        guard let text = textField.text?.replacingOccurrences(of: " ", with: ""), !text.isEmpty else {
            return
        }
        guard let handler = passwordConfirmHandler else {
            return
        }
        if handler() {
            updateLabelHandler?((.correspond, .systemGreen))
        } else {
            updateLabelHandler?((.notCorrespond, .systemRed))
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstResponserHandler?()
        return true
    }
}

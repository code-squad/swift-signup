//
//  PwTextFieldDelegate.swift
//  SignUpApp
//
//  Created by sonjuhyeong on 2021/03/30.
//

import UIKit

class PwTextFieldDelegate: TextFieldDelegate {
    
    override func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if (regex.isValidPassword(pw: text) == 5) {
            textField.layer.borderColor = UIColor.systemGreen.cgColor
        }else {
            textField.layer.borderColor = UIColor.systemRed.cgColor
        }
    }
}

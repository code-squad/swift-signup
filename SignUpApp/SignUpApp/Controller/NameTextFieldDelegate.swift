//
//  nameTextFieldDelegate.swift
//  SignUpApp
//
//  Created by sonjuhyeong on 2021/03/30.
//

import UIKit

class NameTextFieldDelegate: TextFieldDelegate {
    
    override func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if text.isEmpty {
            textField.layer.borderColor = UIColor.systemRed.cgColor
        }else {
            textField.layer.borderColor = UIColor.systemGreen.cgColor
        }
    }
}

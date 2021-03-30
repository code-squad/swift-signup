//
//  TextFieldDelegate.swift
//  SignUp
//
//  Created by 오킹 on 2021/03/29.
//

import UIKit

class BaseTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.systemBlue.cgColor
    }
  
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = CGColor(red: 112, green: 112, blue: 112, alpha: 1)
    }
}


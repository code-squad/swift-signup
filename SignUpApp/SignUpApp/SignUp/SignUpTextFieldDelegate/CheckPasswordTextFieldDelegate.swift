//
//  CheckPasswordTextFieldDelegate.swift
//  SignUpApp
//
//  Created by Jun Ho JANG on 2021/03/31.
//

import UIKit

class CheckPasswordTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    var delegatedObject: CheckDelegation?
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.layer.borderColor = UIColor.black.cgColor
        delegatedObject?.checkPasswordEquality()
        delegatedObject?.buttonStateCondition()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

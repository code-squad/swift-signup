//
//  NameTextFieldDelegate.swift
//  SignUp
//
//  Created by 양준혁 on 2021/03/30.
//

import UIKit

class NameTextFieldDelegate: NSObject, UITextFieldDelegate {
                      
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.blue.cgColor
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        NotificationCenter.default.post(name: NSNotification.Name("name"), object: nil)
        return true
    }
}

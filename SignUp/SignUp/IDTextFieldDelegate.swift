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
            textField.layer.borderColor = #colorLiteral(red: 0.1540483236, green: 0.6966413856, blue: 0.1375852525, alpha: 1)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Correct"), object: nil)
        } else {
            textField.layer.borderWidth = 1.0
            textField.layer.borderColor = #colorLiteral(red: 0.9967475533, green: 0.03828956559, blue: 0.05758263916, alpha: 1)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Incorrect"), object: nil)
        }
        return true
    }
}


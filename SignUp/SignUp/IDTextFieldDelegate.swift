//
//  IDTextFieldDelegate.swift
//  SignUp
//
//  Created by 양준혁 on 2021/03/29.
//

import UIKit

class IDTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    private var state: IDTextFieldState?
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.blue.cgColor
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        let text = textField.text ?? ""
        let extract = text.getArrayAfterRegex(regex: "[0-9a-z_-]+")
        if extract == [] || (extract[0] != text) {
            textField.layer.borderWidth = 1.0
            textField.layer.borderColor = #colorLiteral(red: 0.9967475533, green: 0.03828956559, blue: 0.05758263916, alpha: 1)
            state = IDTextFieldState.incorrect
        } else if extract[0] == textField.text && text.count > 4 && text.count < 21 {
            textField.layer.borderWidth = 1.0
            textField.layer.borderColor = #colorLiteral(red: 0.1540483236, green: 0.6966413856, blue: 0.1375852525, alpha: 1)
            state = IDTextFieldState.correct
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "identifier"), object: state)
        return true
    }
}

enum IDTextFieldState {
    case incorrect
    case correct
}


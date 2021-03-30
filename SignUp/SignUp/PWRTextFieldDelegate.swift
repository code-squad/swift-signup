//
//  PWRTextFieldDelegate.swift
//  SignUp
//
//  Created by 양준혁 on 2021/03/30.
//

import UIKit

class PWRTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        NotificationCenter.default.post(name: NSNotification.Name("passwordReconfirm"), object: nil)
        return true
    }
}

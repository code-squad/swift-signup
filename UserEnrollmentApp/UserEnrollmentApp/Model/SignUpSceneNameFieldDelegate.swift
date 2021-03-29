//
//  SignUpSceneNameFieldDelegate.swift
//  UserEnrollmentApp
//
//  Created by 조중윤 on 2021/03/29.
//

import UIKit

class SignUpSceneNameFieldDelegate: NSObject, UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing: \((textField.text) ?? "Empty")")
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing: \((textField.text) ?? "Empty")")
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn \((textField.text) ?? "Empty")")
        textField.resignFirstResponder()
        return true
    }
}

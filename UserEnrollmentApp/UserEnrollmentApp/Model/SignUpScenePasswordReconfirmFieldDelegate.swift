//
//  SignUpScenePasswordReconfirmFieldDelegate.swift
//  UserEnrollmentApp
//
//  Created by 조중윤 on 2021/03/29.
//

import UIKit

class SignUpScenePasswordReconfirmFieldDelegate: NSObject, UITextFieldDelegate {
    public var resultNotifyingDelegate: ResultNotifyingDelegate?
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing: \((textField.text) ?? "Empty")")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let inputText = textField.text {
            resultNotifyingDelegate?.passTextFieldValue(sender: self, value: inputText)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn \((textField.text) ?? "Empty")")
        textField.resignFirstResponder()
        return true
    }
}

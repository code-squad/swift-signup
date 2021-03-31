//
//  SignUpSceneNameFieldDelegate.swift
//  UserEnrollmentApp
//
//  Created by 조중윤 on 2021/03/29.
//

import UIKit

class SignUpSceneNameTextFieldDelegate: NSObject, UITextFieldDelegate {
    public var resultNotifyingDelegate: ResultNotifyingDelegate?
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let inputText = textField.text {
            let validationResult = UserInputValidator.validateName(inputText)
            let explanation = validationResult ? "" : "이름은 필수 입력 항목입니다"
            resultNotifyingDelegate?.passValidationResult(sender: self, result: validationResult, explanation: "\(explanation)")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

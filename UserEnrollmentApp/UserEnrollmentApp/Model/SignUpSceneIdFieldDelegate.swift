//
//  TextFieldDelegate.swift
//  UserEnrollmentApp
//
//  Created by 조중윤 on 2021/03/29.
//

import UIKit

class SignUpSceneIdFieldDelegate: NSObject, UITextFieldDelegate {
    public var resultNotifyingDelegate: ResultNotifyingDelegate?
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing: \((textField.text) ?? "Empty")")
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let inputText = textField.text {
            let regexPattern = "[a-z0-9_)(-]{5,20}"
            let validationResult = UserInputValidator.valiidateId(inputText, with: regexPattern)
            let explanation = validationResult ? "사용 가능한 아이디입니다." : "5~20자의 영문 소문자, 숫자와 특수기호(_)(-) 만 사용 가능합니다."
            resultNotifyingDelegate?.showValidationResult(sender: self, result: validationResult, explanation: "\(explanation)")
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn \((textField.text) ?? "Empty")")
        textField.resignFirstResponder()
        return true
    }
}

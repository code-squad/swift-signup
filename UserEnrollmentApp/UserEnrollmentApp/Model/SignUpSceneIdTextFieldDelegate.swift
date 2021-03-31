//
//  TextFieldDelegate.swift
//  UserEnrollmentApp
//
//  Created by 조중윤 on 2021/03/29.
//

import UIKit

class SignUpSceneIdTextFieldDelegate: NSObject, UITextFieldDelegate {
    public var resultNotifyingDelegate: ResultNotifyingDelegate?
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let inputText = textField.text {
            var validationResult: Bool = false
            var explanation: String = ""
            
            UserInputValidator.lookupId(inputText) { (isDuplicated) in
                if isDuplicated {
                    explanation = "이미 존재하는 아이디입니다."
                    validationResult = false
                    DispatchQueue.main.async {
                        self.resultNotifyingDelegate?.passValidationResult(sender: self, result: validationResult, explanation: "\(explanation)")
                    }
                    return
                }
            }
            
            guard UserInputValidator.validateId(inputText) else {
                explanation = "8자 이상 16자 이하로 입력해주세요."
                validationResult = false
                resultNotifyingDelegate?.passValidationResult(sender: self, result: validationResult, explanation: "\(explanation)")
                return
            }
            
            validationResult = true
            explanation = "사용 가능한 아이디입니다."
            resultNotifyingDelegate?.passValidationResult(sender: self, result: validationResult, explanation: "\(explanation)")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

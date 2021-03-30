//
//  File.swift
//  UserEnrollmentApp
//
//  Created by 조중윤 on 2021/03/29.
//

import UIKit

class SignUpScenePasswordFieldDelegate: NSObject, UITextFieldDelegate {
    public var resultNotifyingDelegate: ResultNotifyingDelegate?
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing: \((textField.text) ?? "Empty")")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let inputText = textField.text {
            var explanation: String
            var validationResult: Bool
            
            guard UserInputValidator.validatePasswordLength(inputText) else {
                explanation = "8자 이상 16자 이하로 입력해주세요."
                validationResult = false
                resultNotifyingDelegate?.passValidationResult(sender: self, result: validationResult, explanation: "\(explanation)")
                return
            }
            
            guard UserInputValidator.validatePasswordContainsCapitalLetter(inputText) else {
                print("sdfsdf")
                explanation = "영문 대문자를 최소 1자 이상 포함해주세요."
                validationResult = false
                resultNotifyingDelegate?.passValidationResult(sender: self, result: validationResult, explanation: "\(explanation)")
                return
            }
            
            guard UserInputValidator.validatePasswordContainsNumber(inputText) else {
                explanation = "숫자를 최소 1자 이상 포함해주세요."
                validationResult = false
                resultNotifyingDelegate?.passValidationResult(sender: self, result: validationResult, explanation: "\(explanation)")
                return
            }
            
            guard UserInputValidator.validatePasswordContainsSpecialCharacter(inputText) else {
                explanation = "특수문자를 최소 1자 이상 포함해주세요."
                validationResult = false
                resultNotifyingDelegate?.passValidationResult(sender: self, result: validationResult, explanation: "\(explanation)")
                return
            }
            
            explanation = "안전한 비밀번호입니다."
            validationResult = true
            resultNotifyingDelegate?.passValidationResult(sender: self, result: validationResult, explanation: "\(explanation)")
            return
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn \((textField.text) ?? "Empty")")
        textField.resignFirstResponder()
        return true
    }
}

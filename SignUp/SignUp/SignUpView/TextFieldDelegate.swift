//
//  TextFieldDelegate.swift
//  SignUp
//
//  Created by 이다훈 on 2021/03/29.
//

import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate {
    
    let complianceChecker = ComplianceChecker()
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let textField = textField as? SignUpTextField else {
            return
        }
        
        let checkResult = complianceChecker.check(target: textField, closure: { errorChecker in
            NotificationCenter.default.post(name: .uiUpdate, object: textField, userInfo: ["result":errorChecker])
        })
        
        NotificationCenter.default.post(name: .uiUpdate, object: textField, userInfo: ["result":checkResult])
        
        return
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let optionalFieldArray = textField.superview?.subviews.filter({
            let item = $0 as? SignUpTextField
            guard let textField = item else {
                return false
            }
            return true
        })
        
        guard let fieldArray = optionalFieldArray else {
            return true
        }
        
        let currentIndex = fieldArray.firstIndex(of: textField)!
        if currentIndex == fieldArray.count - 1 {
            textField.endEditing(true)
        }
        else{
            textField.endEditing(true)
            fieldArray[currentIndex+1].becomeFirstResponder()
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let optionalFieldArray = textField.superview?.subviews.filter({
            let item = $0 as? SignUpTextField
            guard item != nil else {
                return false
            }
            return true
        })
        
        guard let fieldArray = optionalFieldArray as? [SignUpTextField] else {
            return
        }
        
        fieldArray.enumerated().forEach({
            if $0.element.layer.borderColor != UIColor.green.cgColor {
                // button disabled
                NotificationCenter.default.post(name: .nextButtonEnableCheck, object: self, userInfo: ["enable":false])
                return
            }
            
            if $0.element.text == nil {
                // button disabled
                NotificationCenter.default.post(name: .nextButtonEnableCheck, object: self, userInfo: ["enable":false])
                return
            }
            
            //button enabled
            NotificationCenter.default.post(name: .nextButtonEnableCheck, object: self, userInfo: ["enable":true])
        })
    }
}

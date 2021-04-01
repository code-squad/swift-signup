//
//  TextFieldDelegate.swift
//  SignUp
//
//  Created by 이다훈 on 2021/03/29.
//

import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate {
    
    let complianceChecker = ComplianceChecker()
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let textField = textField as? SignUpTextField else {
            return
        }
        
        let checkResult = complianceChecker.check(target: textField, closure: { errorChecker in
            textField.changeStyle(with: errorChecker)
        })
        
        textField.changeStyle(with: checkResult)
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
}

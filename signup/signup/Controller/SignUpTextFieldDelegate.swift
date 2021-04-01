//
//  SignupTextFieldModel.swift
//  signup
//
//  Created by Song on 2021/03/29.
//

import UIKit

class SignUpTextFieldDelegate: NSObject {

    private let validateManager: ValidateManager
    
    init(validateManager: ValidateManager) {
        self.validateManager = validateManager
    }
    
    private func postNotiToStateChanged(with userInfo: [String: Any]) {
        NotificationCenter.default.post(name: Notification.Name("stateChanged"),
                                        object: validateManager.self,
                                        userInfo: userInfo)
    }
    
    private func postNotiValidateDone() {
        NotificationCenter.default.post(name: Notification.Name("validateDone"),
                                        object: validateManager.self,
                                        userInfo: nil)
    }
    
    private func changeBorderColor(of textField: UITextField, to colorCode: String) {
        DispatchQueue.main.async {
            textField.layer.borderColor = UIColor(named: colorCode)?.cgColor
        }
    }
}

extension SignUpTextFieldDelegate: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.endEditing(true)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        changeBorderColor(of: textField, to: "PointBlue")
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let input = textField.text ?? ""
        
        validateManager.isValid(input) { (status) in
            let color = status.isValidated ? "PointGreen" : "PointRed"
            self.changeBorderColor(of: textField, to: color)
            
            let userInfo = ["status": status]
            self.postNotiToStateChanged(with: userInfo)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let input = textField.text ?? ""
        
        validateManager.isValid(input) { (status) in
            var userInfo: [String: Any] = ["status": status]
            
            if status.isValidated {
                self.changeBorderColor(of: textField, to: "PointGreen")
                userInfo["input"] = input
                self.postNotiValidateDone()
            } else {
                DispatchQueue.main.async {
                    textField.becomeFirstResponder()
                    self.changeBorderColor(of: textField, to: "PointRed")
                }
            }
            self.postNotiToStateChanged(with: userInfo)
        }
    }
}

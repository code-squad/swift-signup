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
    
    enum NotiKeys {
        static let stateChanged = Notification.Name("stateChanged")
        static let validateDone = Notification.Name("validateDone")
    }
    
    private func postNotiToStateChanged(with userInfo: [String: Any]) {
        NotificationCenter.default.post(name: NotiKeys.stateChanged,
                                        object: validateManager.self,
                                        userInfo: userInfo)
    }
    
    private func postNotiValidateDone() {
        NotificationCenter.default.post(name: NotiKeys.validateDone,
                                        object: validateManager.self,
                                        userInfo: nil)
    }
    
    private func changeBorderColor(of textField: UITextField, to color: UIColor?) {
        DispatchQueue.main.async {
            textField.layer.borderColor = color?.cgColor
        }
    }
}

extension SignUpTextFieldDelegate: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.endEditing(true)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        changeBorderColor(of: textField, to: ColorSet.PointBlue)
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let input = textField.text ?? ""
        
        validateManager.isValid(input) { (status) in
            let color = status.isValidated ? ColorSet.PointGreen : ColorSet.PointRed
            self.changeBorderColor(of: textField, to: color)
            
            let userInfo = ["status": status]
            self.postNotiToStateChanged(with: userInfo)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let input = textField.text ?? ""
        
        validateManager.isValid(input) { (status) in
            let userInfo: [String: Any] = ["status": status]
            
            if status.isValidated {
                self.changeBorderColor(of: textField, to: ColorSet.PointGreen)
                self.postNotiValidateDone()
            } else {
                DispatchQueue.main.async {
                    textField.becomeFirstResponder()
                    self.changeBorderColor(of: textField, to: ColorSet.PointRed)
                }
            }
            self.postNotiToStateChanged(with: userInfo)
        }
    }
}

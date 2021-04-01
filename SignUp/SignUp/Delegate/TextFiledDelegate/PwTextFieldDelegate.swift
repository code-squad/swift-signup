//
//  PwTextFieldDelegate.swift
//  SignUp
//
//  Created by 오킹 on 2021/03/30.
//

import UIKit

class PwTextFieldDelegate: BaseTextFieldDelegate {

    static let notificationName = NSNotification.Name("updatePwResultLabel")
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text ?? "") as NSString
        let newText = text.replacingCharacters(in: range, with: string)
        let isCorrect = Validator.isCorrected(pw: newText)
        let result = isCorrect

            isCorrect.keys.forEach{ isCorrect in
                textField.layer.borderColor = isCorrect ? UIColor.systemGreen.cgColor : UIColor.systemRed.cgColor
        }
        NotificationCenter.default.post(name: PwTextFieldDelegate.notificationName, object: self, userInfo: result)

        return true
    }
}

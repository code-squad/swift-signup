//
//  IdTextFieldDelegate.swift
//  SignUp
//
//  Created by 오킹 on 2021/03/30.
//

import UIKit

class IdTextFieldDelegate: BaseTextFieldDelegate {

    static let notificationName = NSNotification.Name("updateIdResultLabel")
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text ?? "") as NSString
        let newText = text.replacingCharacters(in: range, with: string)
        let isCorrect = Validater.isCorrected(id: newText)
        let result = ["correctId":isCorrect]

        textField.layer.borderColor = isCorrect ? UIColor.systemGreen.cgColor : UIColor.systemRed.cgColor
        NotificationCenter.default.post(name: IdTextFieldDelegate.notificationName, object: self, userInfo: result)

        return true
    }
}

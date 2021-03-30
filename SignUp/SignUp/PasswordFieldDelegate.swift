//
//  PasswordDelegate.swift
//  SignUp
//
//  Created by Ador on 2021/03/29.
//

import UIKit

class PasswordFieldDelegate: NSObject, UITextFieldDelegate {
    
    var updateLabelHandler: (((PasswordCheck, UIColor)) -> Void)?
    var firstResponserHandler: (() -> Void)?
 
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 0
        guard let text = textField.text?.replacingOccurrences(of: " ", with: ""), !text.isEmpty,
              let data = validateFormat(for: text) else {
            updateLabelHandler?((.empty, .systemRed))
            return
        }
        updateLabelHandler?(data)
    }
    
    func validateFormat(for password: String) -> (PasswordCheck, UIColor)? {
        let upperPredicate = NSPredicate(format:"SELF MATCHES %@", "(?=.*[A-Z])[A-Za-z0-9!@#$%].*$")
        let numberPredicate = NSPredicate(format:"SELF MATCHES %@", "(?=.*[0-9])[A-Za-z0-9!@#$%].*$")
        let specialCharPredicate = NSPredicate(format:"SELF MATCHES %@", "(?=.*[!@#$%])[A-Za-z0-9!@#$%].*$")
        if password.count < 8 || password.count > 16 {
            return (.notEnoughLength, .systemRed)
        }
        if !upperPredicate.evaluate(with: password) {
            return (.noUppercase, .systemRed)
        }
        if !numberPredicate.evaluate(with: password) {
            return (.noNumber, .systemRed)
        }
        if !specialCharPredicate.evaluate(with: password) {
            return (.noSpecialChar, .systemRed)
        }
        return (.safe, .systemGreen)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstResponserHandler?()
        return true
    }
}

enum PasswordCheck: String {
    case notEnoughLength = "8자 이상 16자 이하로 입력해주세요."
    case noUppercase = "영문 대문자를 최소 1자 이상 포함해주세요."
    case noNumber = "숫자를 최소 1자 이상 포함해주세요."
    case noSpecialChar = "특수문자를 최소 1자 이상 포함해주세요."
    case safe = "안전한 비밀번호 입니다."
    case empty = "비밀번호를 입력해주세요."
    case notCorrespond = "비밀번호가 일치하지 않습니다."
    case correspond = "비밀번호가 일치합니다."
}

//
//  PWTextFieldDelegate.swift
//  SignUp
//
//  Created by 양준혁 on 2021/03/29.
//

import UIKit

class PasswordTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    private var passwordLabel: UILabel
    private var passwordChecker: PasswordChecker
    
    init(label: UILabel) {
        self.passwordLabel = label
        passwordChecker = PasswordChecker()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.blue.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        passwordChecker.check(text: text) { (state) in
            self.updateLabel(state: state, label: self.passwordLabel, textField: textField)
        }
    }
    
    func updateLabel(state: PasswordState, label: UILabel, textField: UITextField) {
        switch state {
        case .notIncludeNumber:
            label.text = "숫자를 최소 1자 이상 포함해주세요."
            label.textColor = #colorLiteral(red: 0.9967475533, green: 0.03828956559, blue: 0.05758263916, alpha: 1)
            textField.layer.borderColor = #colorLiteral(red: 0.9967475533, green: 0.03828956559, blue: 0.05758263916, alpha: 1)
        case .notIncludeUpperCase:
            label.text = "영문 대문자를 최소 1자 이상 포함해주세요."
            label.textColor = #colorLiteral(red: 0.9967475533, green: 0.03828956559, blue: 0.05758263916, alpha: 1)
            textField.layer.borderColor = #colorLiteral(red: 0.9967475533, green: 0.03828956559, blue: 0.05758263916, alpha: 1)
        case .incorrectPWCount:
            label.text = "5~20자의 영문 소문자, 숫자와 특수기호(_)(-) 만 사용 가능합니다."
            label.textColor = #colorLiteral(red: 0.9967475533, green: 0.03828956559, blue: 0.05758263916, alpha: 1)
            textField.layer.borderColor = #colorLiteral(red: 0.9967475533, green: 0.03828956559, blue: 0.05758263916, alpha: 1)
        case .notIncludeSpecialCharacter:
            label.text = "특수문자를 최소 1자 이상 포함해주세요."
            label.textColor = #colorLiteral(red: 0.9967475533, green: 0.03828956559, blue: 0.05758263916, alpha: 1)
            textField.layer.borderColor = #colorLiteral(red: 0.9967475533, green: 0.03828956559, blue: 0.05758263916, alpha: 1)
        case .correct:
            label.text = "안전한 비밀번호입니다."
            label.textColor = #colorLiteral(red: 0.1540483236, green: 0.6966413856, blue: 0.1375852525, alpha: 1)
            textField.layer.borderColor = #colorLiteral(red: 0.1540483236, green: 0.6966413856, blue: 0.1375852525, alpha: 1)
        }
    }
}

enum PasswordState {
    case notIncludeNumber
    case notIncludeUpperCase
    case incorrectPWCount
    case notIncludeSpecialCharacter
    case correct
}

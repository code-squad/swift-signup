//
//  LabelManager.swift
//  SignUp
//
//  Created by 양준혁 on 2021/03/29.
//

import UIKit

class LabelManager {
    
    func checkCorrectID(label: UILabel, state: IDTextFieldState) {
        switch state {
        case .correct:
            label.text = "사용 가능합니다."
            label.textColor = #colorLiteral(red: 0.1540483236, green: 0.6966413856, blue: 0.1375852525, alpha: 1)
        case .alreadyUse:
            label.text = "이미 사용중인 아이디입니다."
            label.textColor = #colorLiteral(red: 0.9967475533, green: 0.03828956559, blue: 0.05758263916, alpha: 1)
        case .incorrect:
            label.text = "5~20자의 영문 소문자, 숫자와 특수기호(_)(-) 만 사용 가능합니다."
            label.textColor = #colorLiteral(red: 0.9967475533, green: 0.03828956559, blue: 0.05758263916, alpha: 1)
        }
    }
    
    func checkPassword(label: UILabel, state: PasswordTextFieldState) {
        switch state {
        case .correct:
            label.text = "안전한 비밀번호입니다."
            label.textColor = #colorLiteral(red: 0.1540483236, green: 0.6966413856, blue: 0.1375852525, alpha: 1)
        case .incorrectPWCount:
            label.text = "8자 이상 16자 이하로 입력해주세요."
            label.textColor = #colorLiteral(red: 0.9967475533, green: 0.03828956559, blue: 0.05758263916, alpha: 1)
        case .notIncludeNumber:
            label.text = "숫자를 최소 1자 이상 포함해주세요."
            label.textColor = #colorLiteral(red: 0.9967475533, green: 0.03828956559, blue: 0.05758263916, alpha: 1)
        case .notIncludeSpecialCharacter:
            label.text = "특수문자를 최소 1자 이상 포함해주세요."
            label.textColor = #colorLiteral(red: 0.9967475533, green: 0.03828956559, blue: 0.05758263916, alpha: 1)
        case .notIncludeUpperCase:
            label.text = "영문 대문자를 최소 1자 이상 포함해주세요."
            label.textColor = #colorLiteral(red: 0.9967475533, green: 0.03828956559, blue: 0.05758263916, alpha: 1)
        default:
            label.text = "조건에 맞게 입력해주세요."
            label.textColor = #colorLiteral(red: 0.9967475533, green: 0.03828956559, blue: 0.05758263916, alpha: 1)
        }
    }
    
    func checkPasswordConfirm(pw: UITextField, pwr: UITextField, pwrLabel: UILabel) {
        if pw.text == pwr.text && pwr.text != "" {
            pwr.layer.borderWidth = 1.0
            pwr.layer.borderColor = #colorLiteral(red: 0.1540483236, green: 0.6966413856, blue: 0.1375852525, alpha: 1)
            pwrLabel.text = "비밀번호가 일치합니다."
            pwrLabel.textColor = #colorLiteral(red: 0.1540483236, green: 0.6966413856, blue: 0.1375852525, alpha: 1)
        } else {
            pwr.layer.borderWidth = 1
            pwr.layer.borderColor = #colorLiteral(red: 0.9967475533, green: 0.03828956559, blue: 0.05758263916, alpha: 1)
            pwrLabel.text = "비밀번호가 일치하지 않습니다."
            pwrLabel.textColor = #colorLiteral(red: 0.9967475533, green: 0.03828956559, blue: 0.05758263916, alpha: 1)
        }
    }
    
    func checkName(name: UITextField, label: UILabel) {
        let text = name.text
        if text == "" {
            name.layer.borderWidth = 1
            name.layer.borderColor = #colorLiteral(red: 0.9967475533, green: 0.03828956559, blue: 0.05758263916, alpha: 1)
            label.text = "이름은 필수 입력 항목입니다."
            label.textColor = #colorLiteral(red: 0.9967475533, green: 0.03828956559, blue: 0.05758263916, alpha: 1)
        } else {
            name.layer.borderWidth = 0
            label.text = ""
            
        }
    }
}

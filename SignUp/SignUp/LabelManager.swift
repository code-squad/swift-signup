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
        case .incorrect:
            label.text = "5~20자의 영문 소문자, 숫자와 특수기호(_)(-) 만 사용 가능합니다."
            label.textColor = #colorLiteral(red: 0.9967475533, green: 0.03828956559, blue: 0.05758263916, alpha: 1)
        default:
            break
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
            break
        }
    }
}

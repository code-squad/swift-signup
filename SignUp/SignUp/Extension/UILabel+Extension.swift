//
//  UILabel+Extension.swift
//  SignUp
//
//  Created by 이다훈 on 2021/03/29.
//

import UIKit

extension UILabel {
    func showMessage(type: TextFieldType, error: TextFormError) {
        var messageString = String()
        switch (type,error) {
        case (TextFieldType.id,TextFormError.ok):
            messageString = "사용 가능한 아이디입니다."
        case (TextFieldType.id,TextFormError.wrong(.idIneligible)):
            messageString = "5~20자의 영문 소문자, 숫자와 특수기호(_,-)만 사용 가능합니다."
        case (TextFieldType.id,TextFormError.wrong(.idUsed)):
            messageString = "이미 사용중인 아이디입니다."
        case (TextFieldType.pw,TextFormError.ok):
            messageString = "안전한 비밀번호입니다."
        case (TextFieldType.pw,TextFormError.wrong(.pwNoNumber)):
            messageString = "숫자를 최소 1자 이상 포함해주세요."
        case (TextFieldType.pw,TextFormError.wrong(.pwNoSpecialCharacter)):
            messageString = "특수문자를 최소 1자 이상 포함해주세요."
        case (TextFieldType.pw,TextFormError.wrong(.pwNoUpperCase)):
            messageString = "영문 대문자를 최소 1자 이상 포함해주세요."
        case (TextFieldType.pw,TextFormError.wrong(.pwOutOfIndex)):
            messageString = "8자 이상 16자 이하로 입력해주세요."
        case (TextFieldType.pw2,TextFormError.ok):
            messageString = "비밀번호가 일치합니다."
        case (TextFieldType.pw2,TextFormError.wrong(.pwDifferent)):
            messageString = "비밀번호가 일치하지 않습니다."
        case (TextFieldType.name,TextFormError.wrong(.nameIsNil)):
            messageString = "이름은 필수 입력 항목입니다."
        default:
            messageString = ""
        }
        self.text = messageString
    }

}

//
//  Constants.swift
//  SignupApp
//
//  Created by Song on 2021/03/31.
//

import Foundation

struct K {
    static let goToProfileSegue = "goToProfile"
    static let userInfoKey = "password"
    
    struct KeyColors {
        static let background = "background"
        static let focusedTextFieldBorder = "focusedTextFieldBorder"
        static let greenText = "greenText"
        static let normalTextFieldBorder = "normalTextFieldBorder"
        static let placeholderText = "placeholderText"
        static let redErrorMessage = "redErrorMessage"
    }
    
    struct Regex {
        static let username = "[a-z0-9_-]{5,20}"
        static let passwordLength = ".{8,16}"
        static let passwordUppercase = "[^A-Z]*[A-Z].*"
        static let passwordDigit = "[^0-9]*[0-9].*"
        static let passwordSpecialCharacter = "[^!@#$%]*[!@#$%].*"
        static let password = "[A-Za-z0-9!@#$%]*"
    }
    
    struct SuccessMessage {
        static let username = "사용 가능한 아이디입니다."
        static let password = "안전한 비밀번호입니다."
        static let confirmPassword = "비밀번호가 일치합니다."
        static let name = ""
    }
    
    struct ErrorMessage {
        static let alreadyExistingUsername = "이미 사용중인 아이디입니다."
        static let username = "5~20자의 영문 소문자, 숫자와 특수기호(_)(-) 만 사용 가능합니다."
        static let passwordLength = "8자 이상 16자 이하로 입력해주세요."
        static let passwordUppercase = "영문 대문자를 최소 1자 이상 포함해주세요."
        static let passwordDigit = "숫자를 최소 1자 이상 포함해주세요."
        static let passwordSpecialCharacter = "특수문자를 최소 1자 이상 포함해주세요."
        static let confirmPassword = "비밀번호가 일치하지 않습니다."
        static let name = "이름은 필수 입력 항목입니다."
    }
}

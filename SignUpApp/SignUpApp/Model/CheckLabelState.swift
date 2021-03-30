//
//  CheckLabelState.swift
//  SignUpApp
//
//  Created by sonjuhyeong on 2021/03/30.
//

import Foundation

class CheckLabelState {
    enum IdState: String {
        case Pass = "사용 가능한 아이디입니다."
        case Invalid = "5~20자의 영문 소문자, 숫자와 특수기호(_)(-) 만 사용 가능합니다."
        case Duplicate = "이미 사용중인 아이디입니다."
    }
    
    enum PwState: String {
        case Pass = "안전한 비밀번호입니다."
        case Invalid = "8자 이상 16자 이하로 입력해주세요."
        case MinimumEnglish = "영문 대문자를 최소 1자 이상 포함해주세요."
        case InvalidNumber = "숫자를 최소 1자 이상 포함해주세요."
        case InvalidSpecialCharacter = "특수문자를 최소 1자 이상 포함해주세요."
    }
    
    enum PwCheckState: String {
        case Pass = "비밀번호가 일치합니다."
        case Invalid = "비밀번호가 일치하지 않습니다."
    }
    
    enum NameState: String {
        case Pass = ""
        case None = "이름은 필수 입력 항목입니다."
    }
}

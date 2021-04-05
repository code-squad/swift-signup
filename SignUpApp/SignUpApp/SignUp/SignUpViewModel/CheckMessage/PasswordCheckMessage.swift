//
//  PasswordCheckMessage.swift
//  SignUpApp
//
//  Created by Jun Ho JANG on 2021/04/03.
//

import Foundation

enum PasswordCheckMessage: String {
    case characterNumberWarning = "8자 이상 16자 이하로 입력해주세요."
    case charcterUpperWarning = "영문 대문자를 최소 1자 이상 포함해주세요."
    case numberIncludedWarning = "숫자를 최소 1자 이상 포함해주세요."
    case specialCharacterWarning = "특수문자를 최소 1자 이상 포함해주세요."
    case validatedCaseMessage = "안전한 비밀번호입니다."
}

//
//  IDCheckMessage.swift
//  SignUpApp
//
//  Created by Jun Ho JANG on 2021/04/04.
//

import Foundation

enum IDCheckMessage: String {
    case usedIDWarning = "이미 사용중인 아이디입니다."
    case charcterWarning = "5~20자의 영문 소문자, 숫자와 특수기호(_)(-)만 사용 가능합니다."
    case validatedCaseMessage = "사용 가능한 아이디입니다."
}

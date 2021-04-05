//
//  ErrorCheckResult.swift
//  SignUp
//
//  Created by 이다훈 on 2021/04/01.
//

import UIKit

protocol ErrorCheckResult {
    var isError : Bool? {get set}
    var message : String {get set}
    func errorColor () -> UIColor
}

class ErrorResult : ErrorCheckResult{
    var isError: Bool?
    var message: String
    
    init(isError : Bool?, message text : String ) {
        self.isError = isError
        self.message = text
    }
    
    convenience init() {
        self.init(isError: nil, message : "")
    }
    
    func errorColor() -> UIColor {
        guard let error = self.isError else{
            return UIColor.black
        }
        return error ? UIColor.red : UIColor.green
    }
}

enum ErrorMessage : String {
    case idIsOk = "사용 가능한 아이디입니다."
    case idIneligible =  "5~20자의 영문 소문자, 숫자와 특수기호(_,-)만 사용 가능합니다."
    case idUsed = "이미 사용중인 아이디입니다."
    case pwIsOk = "안전한 비밀번호입니다."
    case pwNoNumber = "숫자를 최소 1자 이상 포함해주세요."
    case pwNoSpecialCharacter = "특수문자를 최소 1자 이상 포함해주세요."
    case pwNoUpperCase =  "영문 대문자를 최소 1자 이상 포함해주세요."
    case pwOutOfIndex =  "8자 이상 16자 이하로 입력해주세요."
    case pw2IsOk = "비밀번호가 일치합니다."
    case pw2Different = "비밀번호가 일치하지 않습니다."
    case nameIsNil = "이름은 필수 입력 항목입니다."
}




//
//  PasswordValidState.swift
//  SignUp
//
//  Created by 박혜원 on 2021/03/31.
//

import Foundation
import Combine

class PasswordValidState : ObservableObject {
    
    enum State : String {
        case valid = "안전한 비밀번호입니다."
        case inValidRange = "8자 이상 16자 이하로 입력해주세요."
        case notIncludeNumber = "숫자를 최소 1자 이상 포함해주세요."
        case notIncludeUpperCase = "영문 대문자를 최소 1자 이상 포함해주세요."
        case notIncludeSpecialCharacter = "특수문자를 최소 1자 이상 포함해주세요."
        case none = "안전하지 않은 비밀번호 입니다."
    }
    var state : State {
        didSet {
            objectWillChange.send()
        }
    }
    
    init(){
        state = .none
    }
    func setValid(){
        state = .valid
    }
    func setInValid(){
        state = .none
    }
}

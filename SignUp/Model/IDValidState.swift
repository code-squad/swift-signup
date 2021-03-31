//
//  ValidStatus.swift
//  SignUp
//
//  Created by 박혜원 on 2021/03/31.
//

import Foundation
import Combine

class IDValidState : ObservableObject{
    
    enum State : String {
        case notValid = "이미 사용중인 아이디입니다."
        case valid = "사용 가능한 아이디입니다."
    }
    
    var state : State {
        didSet {
            objectWillChange.send()
        }
    }
    init(){
        state = .notValid
    }
    func setValid(){
        state = State.valid
    }
    func setNotValid(){
        state = State.notValid
    }
}

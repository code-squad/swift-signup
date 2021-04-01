//
//  NameValidState.swift
//  SignUp
//
//  Created by 박혜원 on 2021/04/01.
//

import Foundation
import Combine

class NameValidState : ObservableObject{
    
    enum State : String {
        case notValid = "필수 항목입니다."
        case valid = ""
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

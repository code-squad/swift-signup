//
//  RePasswordValidState.swift
//  SignUp
//
//  Created by 박혜원 on 2021/04/01.
//

import Foundation

class RePasswordValidState : ObservableObject {
    enum State : String {
        case equal = ""
        case notEqual = "비밀번호가 일치하지 않습니다."
    }
    var state : State {
        didSet {
            objectWillChange.send()
        }
    }
    
    init(){
        state = .notEqual
    }
    func chageState(to state : State){
        self.state = state
    }
}

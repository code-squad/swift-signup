//
//  NameValidState.swift
//  SignUp
//
//  Created by 박혜원 on 2021/04/01.
//

import Foundation

class NameValidState : ObservableObject{
    
    enum State : String {
        case inValid = "필수 항목입니다."
        case valid = ""
    }
    
    var state : State {
        didSet {
            objectWillChange.send()
        }
    }
    init(){
        state = .inValid
    }
    func chageState(to state : State){
        self.state = state
    }
}

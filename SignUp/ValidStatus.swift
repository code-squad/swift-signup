//
//  ValidStatus.swift
//  SignUp
//
//  Created by 박혜원 on 2021/03/31.
//

import Foundation
import Combine

class IDValidStatus : ObservableObject{
    
    enum Status : String {
        case notValid = "사용 가능하지 않은 아이디 입니다."
        case valid = "사용가능한 아이디 입니다."
    }
    
    var state : Status {
        didSet {
            objectWillChange.send()
        }
    }
    init(){
        state = .notValid
    }
    func setValid(){
        state = Status.valid
    }
    func setNotValid(){
        state = Status.notValid
    }
}

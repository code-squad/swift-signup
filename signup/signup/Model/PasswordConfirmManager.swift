//
//  PasswordConfirmManager.swift
//  signup
//
//  Created by Song on 2021/03/31.
//

import Foundation

class PasswordConfirmManager: ValidateManager {
    
    private var status: Status
    private let invalidMessages: [String]
    private let validMessage: String

    init(status: Status, invalidMessages: [String], validMessage: String) {
        self.status = status
        self.invalidMessages = invalidMessages
        self.validMessage = validMessage
    }
    
    convenience init() {
        let differentInput = "비밀번호가 일치하지 않습니다"
        let passwordConfirm = "비밀번호가 일치합니다"
        
        self.init(status: Status(isValidated: false, message: ""),
                  invalidMessages: [differentInput],
                  validMessage: passwordConfirm)
    }
    
    
    func check(_ inputs: [String]) -> Status {
        let password = inputs[0]
        let confirm = inputs[1]
        status.isValidated = false
        
        if !isSame(password, confirm) {
            status.message = invalidMessages[0]
        } else {
            status.isValidated = true
            status.message = validMessage
        }
        return status
    }
    
    private func isSame(_ password: String, _ confirm: String) -> Bool {
        return password == confirm ? true : false
    }
}

//
//  PasswordConfirmManager.swift
//  signup
//
//  Created by Song on 2021/03/31.
//

import Foundation

class PasswordConfirmManager: ValidateManager, ValidReturnable {
    
    private var status: Status
    private let invalidMessages: [String]
    private let validMessage: String
    
    private var confirmedPassword: String?
    
    private let validPasswordReturner: ValidReturnable

    init(status: Status, invalidMessages: [String], validMessage: String, validPasswordReturner: ValidReturnable) {
        self.status = status
        self.invalidMessages = invalidMessages
        self.validMessage = validMessage
        self.validPasswordReturner = validPasswordReturner
    }
    
    convenience init(validPasswordReturner: ValidReturnable) {
        let differentInput = "비밀번호가 일치하지 않습니다"
        let passwordConfirm = "비밀번호가 일치합니다"
        
        self.init(status: Status(isValidated: false, message: ""),
                  invalidMessages: [differentInput],
                  validMessage: passwordConfirm,
                  validPasswordReturner: validPasswordReturner)
    }
    
    func validatedInput() -> String? {
        return confirmedPassword
    }
    
    func isValid(_ input: String, completionHandler: @escaping (Status) -> Void) {
        confirmedPassword = nil
        status.isValidated = false
        
        let password = validPasswordReturner.validatedInput() ?? ""
        let confirm = input
        
        if !isSame(password, confirm) {
            status.message = invalidMessages[0]
        } else {
            status.isValidated = true
            status.message = validMessage
            confirmedPassword = confirm
        }
        completionHandler(status)
    }
    
    private func isSame(_ password: String, _ confirm: String) -> Bool {
        return password == confirm ? true : false
    }
}

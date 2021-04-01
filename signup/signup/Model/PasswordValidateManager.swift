//
//  PasswordValidateManager.swift
//  signup
//
//  Created by Song on 2021/03/31.
//

import Foundation

class PasswordValidateManager: ValidateManager {

    private var status: Status
    private let invalidMessages: [String]
    private let validMessage: String

    init(status: Status, invalidMessages: [String], validMessage: String) {
        self.status = status
        self.invalidMessages = invalidMessages
        self.validMessage = validMessage
    }
    
    convenience init() {
        let countInvalid = "8자 이상 16자 이하로 입력해주세요"
        let uppercaseNotIncluded = "영문 대문자를 1개 이상 포함해주세요"
        let numberNotIncluded = "숫자를 1개 이상 포함해주세요"
        let symbolNotIncluded = "특수문자를 1개 이상 포함해주세요"
        
        let passwordValid = "안전한 비밀번호입니다"
        
        self.init(status: Status(isValidated: false, message: ""),
                  invalidMessages: [countInvalid,
                                    uppercaseNotIncluded,
                                    numberNotIncluded,
                                    symbolNotIncluded],
                  validMessage: passwordValid)
    }
    
    func isValid(_ input: String, completionHandler: @escaping (Status) -> Void) {
        let password = input
        status.isValidated = false
        
        if !isCountValid(password) {
            status.message = invalidMessages[0]
        } else if !isUppercaseIncluded(password) {
            status.message = invalidMessages[1]
        } else if !isNumberIncluded(password) {
            status.message = invalidMessages[2]
        } else if !isSymbolIncluded(password) {
            status.message = invalidMessages[3]
        } else {
            status.isValidated = true
            status.message = validMessage
        }
        completionHandler(status)
    }
    
    private func isCountValid(_ password: String) -> Bool {
        return password.count >= 8 && password.count <= 16 ? true : false
    }
    
    private func isUppercaseIncluded(_ password: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: "(?=.*[A-Z])",
                                            options: .anchorsMatchLines)
        let match = regex.firstMatch(in: password,
                                     options: .reportCompletion,
                                     range: .init(location: 0, length: password.count))
        return match != nil ? true : false
    }
    
    private func isNumberIncluded(_ password: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: "(?=.*[0-9])",
                                            options: .anchorsMatchLines)
        let match = regex.firstMatch(in: password,
                                     options: .reportCompletion,
                                     range: .init(location: 0, length: password.count))
        return match != nil ? true : false
    }
    
    private func isSymbolIncluded(_ password: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: "(?=.*[^a-zA-Z0-9가-힣])",
                                            options: .anchorsMatchLines)
        let match = regex.firstMatch(in: password,
                                     options: .reportCompletion,
                                     range: .init(location: 0, length: password.count))
        return match != nil ? true : false
    }
}

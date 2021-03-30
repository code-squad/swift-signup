//
//  SignUpValidation.swift
//  signup
//
//  Created by Song on 2021/03/29.
//

import Foundation

class SignUpErrorManager: ErrorManager {
    
    enum ErrorMessage {
        static let idStyle = "5~20자의 소문자, 숫자, 특수문자(_,-)만 입력 가능"
        static let idExisting = "이미 존재하는 아이디입니다"
        static let passwordCount = "8자 이상 16자 이하로 입력해주세요"
        static let passwordUpperCase = "영문 대문자를 1개 이상 포함해주세요"
        static let passwordNumber = "숫자를 1개 이상 포함해주세요"
        static let passwordSymbol = "특수문자를 1개 이상 포함해주세요"
        static let passwordMatch = "비밀번호가 일치하지 않습니다"
        static let name = "이름은 필수 입력 값입니다"
    }

    func id(_ id: String) -> String? {
        if let styleError = idStyle(id) {
            return styleError
        }
        
        if let overlapError = idExisting(id) {
            return overlapError
        }
        return nil
    }
    
    private func idStyle(_ id: String) -> String? {
        let regex = try! NSRegularExpression(pattern: "^[a-z0-9_-]{5,20}$",
                                             options: .anchorsMatchLines)
        let match = regex.firstMatch(in: id,
                                     options: .reportCompletion,
                                     range: .init(location: 0, length: id.count))
        return match == nil ? ErrorMessage.idStyle : nil
    }
    
    private func idExisting(_ id: String) -> String? {
        //To-do: 서버에서 중복 아이디를 확인한다.
        return nil
    }
    
    func password(_ password: String) -> String? {
        if let countError = passwordCount(password) {
            return countError
        }
        
        if let upperCaseError = passwordUpperCase(password) {
            return upperCaseError
        }
        
        if let numberError = passwordNumber(password) {
            return numberError
        }
        
        if let symbolError = passwordSymbol(password) {
            return symbolError
        }
        return nil
    }
    
    private func passwordCount(_ password: String) -> String? {
        return password.count < 8 || password.count > 16 ? ErrorMessage.passwordCount : nil
    }
    
    private func passwordUpperCase(_ password: String) -> String? {
        let regex = try! NSRegularExpression(pattern: "(?=.*[A-Z])",
                                            options: .anchorsMatchLines)
        let match = regex.firstMatch(in: password,
                                     options: .reportCompletion,
                                     range: .init(location: 0, length: password.count))
        return match == nil ? ErrorMessage.passwordUpperCase : nil
    }
    
    private func passwordNumber(_ password: String) -> String? {
        let regex = try! NSRegularExpression(pattern: "(?=.*[0-9])",
                                            options: .anchorsMatchLines)
        let match = regex.firstMatch(in: password,
                                     options: .reportCompletion,
                                     range: .init(location: 0, length: password.count))
        return match == nil ? ErrorMessage.passwordNumber : nil
    }
    
    private func passwordSymbol(_ password: String) -> String? {
        let regex = try! NSRegularExpression(pattern: "(?=.*[^a-zA-Z0-9가-힣])",
                                            options: .anchorsMatchLines)
        let match = regex.firstMatch(in: password,
                                     options: .reportCompletion,
                                     range: .init(location: 0, length: password.count))
        return match == nil ? ErrorMessage.passwordSymbol : nil
    }
    
    func passwordDoubleCheck(first password: String, second doubleChecked: String) -> String? {
        return password == doubleChecked ? nil : ErrorMessage.passwordMatch
    }
    
    func name(_ name: String) -> String? {
        return name.count > 0 ? nil : ErrorMessage.name
    }
}

//
//  ValidationCheck.swift
//  SignUp
//
//  Created by 박혜원 on 2021/03/31.
//

import Foundation

struct RegularExpression {
    
    typealias Length = (start : Int, end: Int)
    
    static let LengthOfPassword : Length = (5,20)
    static let LengthOfId : Length = (8,16)
    
    static let digit = "[:digit:]"
    static let lower = "[:lower:]"
    static let upper = "[:upper:]"
    static let special = "[:punct:]"
    static let rangeOfId = "^().{\(LengthOfId.start),\(LengthOfId.end)}"
    static let rangeOfPassword = "^().{\(LengthOfPassword.start),\(LengthOfPassword.end)}"
}

struct ValidationCheckService {

    static func isValidId(with text : String) -> IDValidState.State {
        // 영문 소문자, 숫자, 특수기호(_,-), 5-20자
        if text.isEmpty {
            return .empty
        }
        if !regularExpressionCheck(with: RegularExpression.digit, target: text) {
            return .inValid
        } else {
            return .valid
        }
    }
    static func isValidPassword(with text : String) -> PasswordValidState.State {
        // 영문 대/소문자, 숫자, 특수문자(!@#$%), 8-16자
        if !regularExpressionCheck(with: RegularExpression.digit, target: text) {
            return .notIncludeNumber
        }
        if !regularExpressionCheck(with: RegularExpression.upper, target: text) {
            return .notIncludeUpperCase
        }
        if !regularExpressionCheck(with: RegularExpression.special, target: text) {
            return .notIncludeSpecialCharacter
        }
        if !regularExpressionCheck(with: RegularExpression.rangeOfPassword, target: text) {
            return .inValidRange
        }
        return .valid
    }
    static func isEqualPassword(to : String, from : String ) -> RePasswordValidState.State {
        if to == from {
            return .equal
        }
        return .notEqual
    }
    static func isValidName(with name : String) -> NameValidState.State {
        if name.isEmpty {
            return .inValid
        }
        return .valid
    }
    static func regularExpressionCheck(with pattern : String, target text : String) -> Bool {
        let regex = try? NSRegularExpression(pattern: pattern)
        if let _ = regex?.firstMatch(in: text, options: [], range: NSRange(location: 0, length: text.count)) {
            return true
        } else {
            return false
        }
    }
}

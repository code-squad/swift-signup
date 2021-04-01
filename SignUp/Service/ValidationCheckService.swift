//
//  ValidationCheck.swift
//  SignUp
//
//  Created by 박혜원 on 2021/03/31.
//

import Foundation


struct ValidationCheckService {
    typealias Length = (start : Int, end: Int)
    
    static let LengthOfPassword : Length = (5,20)
    static let LengthOfId : Length = (8,16)
        
    static func isValidId(input text : String) -> IDValidState.State {
        // 영문 소문자, 숫자, 특수기호(_,-), 5-20자
        if !isIncludeLower(text) {
            return .inValid
        } else {
            return .valid
        }
    }
    static func isValidPassword(input text : String) -> PasswordValidState.State {
        // 영문 대/소문자, 숫자, 특수문자(!@#$%), 8-16자
        if !isIncludeNumber(text) {
            return .notIncludeNumber
        } else if !isIncludeUpper(text) {
            return .notIncludeUpperCase
        } else if !isIncludeSpecial(text) {
            return .notIncludeSpecialCharacter
        } else if !isInRange(LengthOfPassword.start, LengthOfPassword.end, text) {
            return .inValidRange
        } else {
            return .valid
        }
        
    }
    static func isValidName(input text: String) -> NameValidState.State {
        if text.isEmpty {
            return .inValid
        } else {
            return .valid
        }
    }
    
    static let isIncludeNumber : (String) -> Bool = { text in
        let pattern = "[:digit:]"
        let regex2 = try? NSRegularExpression(pattern: pattern)
        if let _ = regex2?.firstMatch(in: text, options: [], range: NSRange(location: 0, length: text.count)) {
            return true
        } else {
            return false
        }
    }
    static let isIncludeLower : (String) -> Bool = { text in
        let pattern = "[:lower:]"
        let regex2 = try? NSRegularExpression(pattern: pattern)
        if let _ = regex2?.firstMatch(in: text, options: [], range: NSRange(location: 0, length: text.count)) {
            return true
        } else {
            return false
        }
    }
    static let isIncludeUpper : (String) -> Bool = { text in
        let pattern = "[:upper:]"
        let regex2 = try? NSRegularExpression(pattern: pattern)
        if let _ = regex2?.firstMatch(in: text, options: [], range: NSRange(location: 0, length: text.count)) {
            return true
        } else {
            return false
        }
    }
    static let isIncludeSpecial : (String) -> Bool = { text in
        let pattern = "[:punct:]"
        let regex2 = try? NSRegularExpression(pattern: pattern)
        if let _ = regex2?.firstMatch(in: text, options: [], range: NSRange(location: 0, length: text.count)) {
            return true
        } else {
            return false
        }
    }
    static let isInRange : (Int, Int, String) -> Bool = { start, end, text in
        let pattern = "^().{\(start),\(end)}"
        let regex2 = try? NSRegularExpression(pattern: pattern)
        if let _ = regex2?.firstMatch(in: text, options: [], range: NSRange(location: 0, length: text.count)) {
            return true
        } else {
            return false
        }
    }
}

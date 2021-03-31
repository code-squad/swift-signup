//
//  ValidationCheck.swift
//  SignUp
//
//  Created by 박혜원 on 2021/03/31.
//

import Foundation

struct ValidationCheckService {
    
    static func isValidId(input text : String) -> Bool {
        // 영문 소문자, 숫자, 특수기호(_,-), 5-20자
        let pattern = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%]).{8,16}"
        let regex = try? NSRegularExpression(pattern: pattern)
        if let _ = regex?.firstMatch(in: text, options: [], range: NSRange(location: 0, length: text.count)) {
            return true
        }else {
            return false
        }
    }
    static func isValidPassword(input text : String) -> Bool {
        // 영문 대/소문자, 숫자, 특수문자(!@#$%), 8-16자
        let pattern = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%]).{8,16}"
        let regex = try? NSRegularExpression(pattern: pattern)
        if let _ = regex?.firstMatch(in: text, options: [], range: NSRange(location: 0, length: text.count)) {
            return true
        }else {
            return false
        }
    }
}

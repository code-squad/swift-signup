//
//  Validater.swift
//  SignUp
//
//  Created by 오킹 on 2021/03/30.
//

import Foundation

struct Validator {
    
    static public func isCorrected(id: String) -> [Bool:String] {
        let result: [Bool : String] = [true : "사용 가능한 아이디 입니다."]

        for expression in RegularExpression.IdRegularExpression.allCases {
            let regex = try? NSRegularExpression(pattern: expression.pattern, options: [])
            guard let _ = regex?.firstMatch(in: id, options: .reportCompletion, range: NSMakeRange(0, id.count)) else {
                return [false: expression.showMessage()]
            }
        }
        return result
    }
    
    static public func isCorrected(pw: String) -> [Bool:String] {
        let result: [Bool : String] = [true : "안전한 비밀번호 입니다."]
 
        for expression in RegularExpression.PwRegularExpression.allCases {
            let regex = try? NSRegularExpression(pattern: expression.pattern, options: [])
            guard let _ = regex?.firstMatch(in: pw, options: .reportCompletion, range: NSMakeRange(0, pw.count)) else {
                return [false: expression.showMessage()]
            }
        }
        return result
    }
    
    static public func isSameText(first: String, second: String) -> [Bool:String] {
        var result: [Bool : String] = [true : "비밀번호가 일치합니다."]
        
        if first != second {
            result = [false : "비밀번호가 일치하지 않습니다."]
        }
        return result
    }
    
    static public func isEmpty(_ text: String) -> [Bool:String] {
        var result: [Bool : String] = [true : "사용 가능한 이름입니다."]
        
        if text == "" || text.isEmpty {
            result = [false : "이름은 필수 입력 항목입니다."]
        }
        return result
    }
}

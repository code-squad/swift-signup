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
}

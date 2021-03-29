//
//  ComplianceChecker.swift
//  SignUp
//
//  Created by 이다훈 on 2021/03/29.
//

import Foundation

struct ComplianceChecker {
    private func regexChekcing(target : String, pattern : String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            
            let regexedTarget = regex.matches(in: target, options: .anchored, range: NSRange(location: 0, length: target.utf16.count))
            let resultString = regexedTarget.map({
                String(describing: target[Range($0.range, in: target)!])
            }).joined()
            
            if resultString == "" {
                return false
            }
            
            if resultString != target {
                return false
            }
        } catch {
            print(error)
        }
        return true
    }
    
    func checkIdTextForm(with text : String) -> idTextFormError {
        if !regexChekcing(target: text, pattern: "([^A-Z][0-9a-z-_]).{3,18}") {
            return .wrong
        }
        // id 중복 시 case return 내용 필요함.
        
        return .ok
    }
}

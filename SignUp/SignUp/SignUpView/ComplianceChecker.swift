//
//  ComplianceChecker.swift
//  SignUp
//
//  Created by 이다훈 on 2021/03/29.
//

import Foundation

struct ComplianceChecker {
    let networkManager = NetworkManager()
    
    private func regexChekcing(target : String, pattern : String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            
            let regexedTarget = regex.matches(in: target, options: [], range: NSRange(location: 0, length: target.utf16.count))
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
    
    func checkIdTextForm(with text : String, closure : @escaping (IdTextFormError)->Void ) {
        var usedCheck : IdTextFormError = .none
        
        if !regexChekcing(target: text, pattern: "([^A-Z][0-9a-z-_]).{3,18}") {
            closure(.wrong)
        }
        
        networkManager.getUserList(closure: { userList in
            if let userList = userList {
                if userList.contains(text) {
                    usedCheck = .used
                } else {
                    usedCheck = .ok
                }
                closure(usedCheck)
            }
        })
    }
    
    func checkPwTextForm(with text : String) -> PwTextFormError {
        if !regexChekcing(target: text, pattern :"([A-Za-z0-9!@#$%]).{7,15}") {
            return .outOfIndex
        }
        
        if !regexChekcing(target: text, pattern :"^.*(?=.*[A-Z])[A-Za-z0-9!@#$%].*$") {
            return .noUpperCase
        }
        
        if !regexChekcing(target: text, pattern :"^.*(?=.*[0-9])[A-Za-z0-9!@#$%].*$") {
            return .noNumber
        }
        
        if !regexChekcing(target: text, pattern :"^.*(?=.*[!@#$%])[A-Za-z0-9!@#$%].*$") {
            return .noSpecialCharacter
        }
        
        return .ok
    }
}


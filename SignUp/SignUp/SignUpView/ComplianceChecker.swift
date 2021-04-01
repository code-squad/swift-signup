//
//  ComplianceChecker.swift
//  SignUp
//
//  Created by 이다훈 on 2021/03/29.
//

import Foundation

struct ComplianceChecker {
    let networkManager = NetworkManager()
    
    func check(target textField: SignUpTextField, closure : @escaping (TextFormError)->Void = {_ in }) -> TextFormError {
        
        guard let text = textField.text else {
            return .none
        }
        
        switch textField.textFieldType {
        case .id:
            return checkIdTextForm(with: text, closure: closure)
        case .pw:
            return checkPwTextForm(with: text)
        case .pw2:
            return checkPwDuplicated(with: textField)
        case .name:
            return checkNameIsNil(with: text)
        default:
            return .none
        }
    }
    
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
    
    private func checkIdTextForm(with text : String, closure: @escaping (TextFormError)->Void) -> TextFormError{
        var errorChecker : TextFormError = .none
        
        networkManager.getUserList(closure: { userList in
            if let userList = userList {
                
                if userList.contains(text) {
                    errorChecker = .wrong(.idUsed)
                } else {
                    errorChecker = .ok
                }
                
                if !regexChekcing(target: text, pattern: "([^A-Z][0-9a-z-_]).{3,18}") {
                    errorChecker = .wrong(.idIneligible)
                }
                closure(errorChecker)
            }
        })
        return errorChecker
    }
    
    private func checkPwTextForm(with text : String) -> TextFormError {
        if !regexChekcing(target: text, pattern :"([A-Za-z0-9!@#$%]).{7,15}") {
            return .wrong(.pwOutOfIndex)
        }
        
        if !regexChekcing(target: text, pattern :"^.*(?=.*[A-Z])[A-Za-z0-9!@#$%].*$") {
            return .wrong(.pwNoUpperCase)
        }
        
        if !regexChekcing(target: text, pattern :"^.*(?=.*[0-9])[A-Za-z0-9!@#$%].*$") {
            return .wrong(.pwNoNumber)
        }
        
        if !regexChekcing(target: text, pattern :"^.*(?=.*[!@#$%])[A-Za-z0-9!@#$%].*$") {
            return .wrong(.pwNoSpecialCharacter)
        }
        
        return .ok
    }
    
    private func checkPwDuplicated(with textField : SignUpTextField) -> TextFormError {
        
        let optionalFieldArray = textField.superview?.subviews.filter({
            let item = $0 as? SignUpTextField
            guard let textField = item else {
                return false
            }
            return true
        }) as? [SignUpTextField]
    
        guard let fieldArray = optionalFieldArray else {
            return .none
        }
        
        if fieldArray[1].text == fieldArray[2].text {
            return .ok
        } else {
            return .wrong(.pwDifferent)
        }
        
    }
    
    private func checkNameIsNil(with text: String) -> TextFormError {
        return text == "" ? .wrong(.nameIsNil) : .ok
    }
}


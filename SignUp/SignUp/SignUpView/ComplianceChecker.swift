//
//  ComplianceChecker.swift
//  SignUp
//
//  Created by 이다훈 on 2021/03/29.
//

import Foundation

struct ComplianceChecker {
    
    func check(target textField: SignUpTextField, closure : @escaping (ErrorCheckResult)->Void = {_ in }) -> ErrorCheckResult {
        
        guard let text = textField.text else {
            return ErrorResult.init()
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
            return ErrorResult.init()
        }
    }
    
    private func generateRegexString(target : String, pattern : String) -> String {
        guard let regex = try? NSRegularExpression(pattern: pattern) else {
            return ""
        }
        
        let regexedTarget = regex.matches(in: target, options: [], range: NSRange(location: 0, length: target.utf16.count))
        let resultString = regexedTarget.map({
            String(describing: target[Range($0.range, in: target)!])
        }).joined()
        
        return resultString
    }
    
    private func regexChekcing(target : String, pattern : String) -> Bool {
        
        let resultString = generateRegexString(target: target, pattern: pattern)
        
        if resultString == "" {
            return false
        }
        
        if resultString != target {
            return false
        }
        
        return true
    }
    
    private func checkIdTextForm(with text : String, closure: @escaping (ErrorCheckResult)->Void) -> ErrorCheckResult{
        let errorChecker = ErrorResult()
        
        if !regexChekcing(target: text, pattern: "([^A-Z][0-9a-z-_]).{3,18}") {
            errorChecker.isError = true
            errorChecker.message = ErrorMessage.idIneligible.rawValue
            return errorChecker
        }
        
        NetworkManager.shared.getUserList(closure: { userList in
            if let userList = userList {
                decideIdError(target: text, array: userList, do: closure)
            }
        })
        return errorChecker
    }
    
    private func decideIdError (target text : String, array userList : [String], do closure: @escaping (ErrorCheckResult)->Void) {
        let errorChecker = ErrorResult()
        
        if userList.contains(text) {
            errorChecker.isError = true
            errorChecker.message = ErrorMessage.idUsed.rawValue
        } else {
            errorChecker.isError = false
            errorChecker.message = ErrorMessage.idIsOk.rawValue
        }
        
        closure(errorChecker)
    }
    
    private func checkPwTextForm(with text : String) -> ErrorCheckResult {
        if !regexChekcing(target: text, pattern :"([A-Za-z0-9!@#$%]).{7,15}") {
            return ErrorResult.init(isError: true, message: ErrorMessage.pwOutOfIndex.rawValue)
        }
        
        if !regexChekcing(target: text, pattern :"^.*(?=.*[A-Z])[A-Za-z0-9!@#$%].*$") {
            return ErrorResult.init(isError: true, message: ErrorMessage.pwNoUpperCase.rawValue)
        }
        
        if !regexChekcing(target: text, pattern :"^.*(?=.*[0-9])[A-Za-z0-9!@#$%].*$") {
            return ErrorResult.init(isError: true, message: ErrorMessage.pwNoNumber.rawValue)
        }
        
        if !regexChekcing(target: text, pattern :"^.*(?=.*[!@#$%])[A-Za-z0-9!@#$%].*$") {
            return ErrorResult.init(isError: true, message: ErrorMessage.pwNoSpecialCharacter.rawValue)
        }
        
        return ErrorResult.init(isError: false, message: ErrorMessage.pwIsOk.rawValue)
    }
    
    private func checkPwDuplicated(with textField : SignUpTextField) -> ErrorCheckResult {
        
        let optionalFieldArray = textField.superview?.subviews.filter({
            let item = $0 as? SignUpTextField
            guard let textField = item else {
                return false
            }
            return true
        }) as? [SignUpTextField]
    
        guard let fieldArray = optionalFieldArray else {
            return ErrorResult()
        }
        
        if fieldArray[1].text == fieldArray[2].text {
            return ErrorResult.init(isError: false, message: ErrorMessage.pw2IsOk.rawValue)
        } else {
            return ErrorResult.init(isError: true, message: ErrorMessage.pw2Different.rawValue)
        }
        
    }
    
    private func checkNameIsNil(with text: String) -> ErrorCheckResult {
        return text == "" ? ErrorResult.init(isError: true, message: ErrorMessage.nameIsNil.rawValue) : ErrorResult.init(isError: false, message: "")
    }
}


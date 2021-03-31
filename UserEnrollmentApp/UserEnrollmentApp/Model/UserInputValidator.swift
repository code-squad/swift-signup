//
//  UserInputValidator.swift
//  UserEnrollmentApp
//
//  Created by 조중윤 on 2021/03/30.
//

import Foundation

class UserInputValidator {
    enum ValidationPattern: String {
        case ValidId = "[a-z0-9_)(-]{5,20}"
        case PasswordLength = ".{8,16}"
        case PasswordContainsCapitalLetter = "[A-Z]+"
        case PasswordContainsNumber = "[0-9]+"
        case PasswordContainsSpecialCharacter = "[!\"#$%&'()*+,-./:;<=>?@\\[\\\\\\]^_`{|}~]+"
        case ValidName = "[a-z0-9A-Z!\"#$%&'()*+,-./:;<=>?@\\[\\\\\\]^_`{|}~]+"
    }
    
    public static func lookupId(_ testingInput: String, completionHandler: @escaping (Bool) -> ()) {
        let urlString: String = "https://8r6ruzgzve.execute-api.ap-northeast-2.amazonaws.com/default/SwiftCamp"
    
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: URLSessionConfiguration.default)
            let task = session.dataTask(with: url) { (data, response, error) in
                guard error == nil else { return }
                guard let safeData = data else { return }
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode([String].self, from: safeData).contains(testingInput)
                    completionHandler(result)
                } catch {
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }
    }
    
    public static func validateId(_ testingInput: String) -> Bool {
        let regexResult = testingInput ~= ValidationPattern.ValidId.rawValue
        
        if regexResult.count != 1 {
            return false
        } else if regexResult.first?.count != testingInput.count {
            return false
        } else {
            return true
        }
    }
    
    public static func validatePasswordLength(_ testingInput: String) -> Bool {
        let regexResult = testingInput ~= ValidationPattern.PasswordLength.rawValue
        
        if regexResult.count != 1 {
            return false
        } else if regexResult.first?.count != testingInput.count {
            return false
        } else {
            return true
        }
    }
    
    public static func validatePasswordContainsCapitalLetter(_ testingInput: String) -> Bool {
        let regexResult = testingInput ~= ValidationPattern.PasswordContainsCapitalLetter.rawValue
        return regexResult.count > 0
    }
    
    public static func validatePasswordContainsNumber(_ testingInput: String) -> Bool {
        let regexResult = testingInput ~= ValidationPattern.PasswordContainsNumber.rawValue
        return regexResult.count > 0
    }
    
    public static func validatePasswordContainsSpecialCharacter(_ testingInput: String) -> Bool {
        let regexResult = testingInput ~= ValidationPattern.PasswordContainsSpecialCharacter.rawValue
        return regexResult.count > 0
    }
    
    public static func validateName(_ testingInput: String) -> Bool {
        let regexResult = testingInput ~= ValidationPattern.ValidName.rawValue
        return regexResult.count > 0
    }
}

extension String {
    static func ~= (lhs: String, rhs: String) -> [String] {
        guard let regex = try? NSRegularExpression(pattern: rhs) else { return [] }
        let range = NSRange(location: 0, length: lhs.utf16.count)
        let result = regex.matches(in: lhs, options: [], range: range)
        
        return result.map { (result) -> String in
            String(lhs[Range(result.range, in: lhs)!])
        }
    }
}

//
//  UserInputValidator.swift
//  UserEnrollmentApp
//
//  Created by 조중윤 on 2021/03/30.
//

import Foundation

class UserInputValidator {
    public static var shared = UserInputValidator()
    
    public static func valiidateId(_ testingId: String, with pattern: String) -> Bool {
        let regexResult = testingId ~= pattern
        
        if regexResult.count != 1 {
            return false
        } else if regexResult.first?.count != testingId.count {
            return false
        } else {
            return true
        }
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

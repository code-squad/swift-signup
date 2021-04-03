//
//  FormatManager.swift
//  SignUp
//
//  Created by Ador on 2021/04/03.
//

import Foundation

class FormatManager {
    static func validate(password: String, completion: (String) -> Void) {
        if password.count < 8 || password.count > 16 {
            completion(PasswordCheck.notEnoughLength.rawValue)
            return
        }
        if !match(format: FormatManager.Format.passwordWithUppercase, with: password) {
            completion(PasswordCheck.noUppercase.rawValue)
            return
        }
        if !match(format: FormatManager.Format.passwordWithNumber, with: password) {
            completion(PasswordCheck.noNumber.rawValue)
            return
        }
        if !match(format: FormatManager.Format.passwordWithSpecialChar, with: password) {
            completion(PasswordCheck.noSpecialChar.rawValue)
            return
        }
        completion(PasswordCheck.safe.rawValue)
    }
    
    static func match(format: String, with value: String) -> Bool {
        let predicate = NSPredicate(format:"SELF MATCHES %@", format)
        return predicate.evaluate(with: value)
    }
    
    enum Format {
        static let id = "[a-z0-9_-]{5,20}"
        static let passwordWithUppercase = "(?=.*[A-Z])[A-Za-z0-9!@#$%].*$"
        static let passwordWithNumber = "(?=.*[0-9])[A-Za-z0-9!@#$%].*$"
        static let passwordWithSpecialChar = "(?=.*[!@#$%])[A-Za-z0-9!@#$%].*$"
    }
}

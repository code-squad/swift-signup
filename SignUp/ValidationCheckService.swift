//
//  ValidationCheck.swift
//  SignUp
//
//  Created by 박혜원 on 2021/03/31.
//

import Foundation

struct ValidationCheckService {
    static func isValidId(input text : String) -> Bool {
        let pattern = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%]).{8,16}"
        let regex = try? NSRegularExpression(pattern: pattern)
        if let _ = regex?.firstMatch(in: text, options: [], range: NSRange(location: 0, length: text.count)) {
            return true
        }else {
            return false
        }
    }
}

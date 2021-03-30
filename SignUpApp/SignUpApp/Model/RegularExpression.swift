//
//  RegularExpression.swift
//  SignUpApp
//
//  Created by sonjuhyeong on 2021/03/30.
//

import Foundation
//import UIKit

class RegularExpression {
    
    //MARK: - ID
    func isValidId(id: String) -> Bool {
        let idRegEx = "[a-z0-9_-]{5,20}"
        let idTest = NSPredicate(format: "SELF MATCHES %@", idRegEx)
        return idTest.evaluate(with: id)
    }
    
    //MARK: - Password
    func isValidPassword(pw: String) -> Int {
        let upperPredicate = NSPredicate(format:"SELF MATCHES %@", "(?=.*[A-Z])[A-Za-z0-9!@#$%].*$")
        let numberPredicate = NSPredicate(format:"SELF MATCHES %@", "(?=.*[0-9])[A-Za-z0-9!@#$%].*$")
        let specialCharPredicate = NSPredicate(format:"SELF MATCHES %@", "(?=.*[!@#$%])[A-Za-z0-9!@#$%].*$")
        if pw.count < 8 || pw.count > 16 {
            return 1
        }
        if !upperPredicate.evaluate(with: pw) {
            return 2
        }
        if !numberPredicate.evaluate(with: pw) {
            return 3
        }
        if !specialCharPredicate.evaluate(with: pw) {
            return 4
        }
        return 5
    }
}

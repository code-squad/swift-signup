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
    func isValidPassword(pw: String) -> Bool {
        let pwRegEx = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%]).{8,16}"
        let pwTest = NSPredicate(format: "SELF MATCHES %@", pwRegEx)
        return pwTest.evaluate(with: pw)
    }
    
}

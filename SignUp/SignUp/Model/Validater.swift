//
//  Validater.swift
//  SignUp
//
//  Created by 오킹 on 2021/03/30.
//

import Foundation

struct Validater {
    
    static public func isCorrected(id: String) -> Bool {
        let regex = "^[a-z0-9_-]{5,20}$"
       
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isCorrect = predicate.evaluate(with: id)
        
        return isCorrect
    }
    
    public func isCorrected(pw: String) {
        
    }
}

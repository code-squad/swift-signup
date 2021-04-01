//
//  IDChecker.swift
//  SignUp
//
//  Created by 양준혁 on 2021/04/01.
//

import Foundation

class IDChecker {
    
    private var state: IDTextFieldState?
    
    func check(text: String, completion: @escaping (IDTextFieldState)->Void) {
        let extract = text.getArrayAfterRegex(regex: "[0-9a-z_-]+")[0]
        RequestManager.requestGet(id: extract) { (result) in
            if result == .exist {
                self.state = IDTextFieldState.alreadyUse
                completion(self.state!)
            }
        }
        if extract != text || extract.count < 5 || extract.count > 20 {
            state = IDTextFieldState.incorrect
            completion(self.state!)
        } else if extract == text && text.count > 4 && text.count < 21 {
            state = IDTextFieldState.correct
            completion(self.state!)
        }
    }
}

//
//  ValidateManager.swift
//  signup
//
//  Created by Song on 2021/03/31.
//

import Foundation

protocol ValidateManager {

    func isValid(_ input: String, completionHandler: @escaping (Status) -> Void)
    
}

struct Status {
 
    var isValidated: Bool
    
    var message: String
    
}

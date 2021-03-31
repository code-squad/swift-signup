//
//  ValidateManager.swift
//  signup
//
//  Created by Song on 2021/03/31.
//

import Foundation

protocol ValidateManager {

    func check(_ inputs: [String]) -> Status
    
}

struct Status {
 
    var isValidated: Bool
    
    var message: String
    
}

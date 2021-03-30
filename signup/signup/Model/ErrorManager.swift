//
//  ErrorManager.swift
//  signup
//
//  Created by Song on 2021/03/30.
//

import Foundation

protocol ErrorManager {
    
    func id(_ id: String) -> String?
    
    func password(_ password: String) -> String?
    
    func passwordDoubleCheck(first password: String, second doubleChecked: String) -> String?
    
    func name(_ name: String) -> String?
}

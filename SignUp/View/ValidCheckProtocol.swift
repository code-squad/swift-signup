//
//  UIBindTextField.swift
//  SignUp
//
//  Created by 박혜원 on 2021/04/01.
//

import UIKit
import Combine

protocol ValidCheckProtocol {
    associatedtype ValidState
    typealias ControlActionClosure = (ValidState) -> ()
    
    var isValid : ValidState { get set }
    func checkValidation() -> Bool
    func bind(control : @escaping ControlActionClosure)
}

//
//  inputErrorEnums.swift
//  SignUp
//
//  Created by 이다훈 on 2021/03/29.
//

import Foundation

enum IdTextFormError {
    case ok
    case used
    case wrong
}

enum PwTextFormError {
    case ok
    case outOfIndex
    case noUpperCase
    case noNumber
    case noSpecialCharacter
}

enum CoincidenceError {
    case ok
    case wrong
}

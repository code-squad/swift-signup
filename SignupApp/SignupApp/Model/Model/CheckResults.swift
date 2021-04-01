//
//  CheckResults.swift
//  SignupApp
//
//  Created by Issac on 2021/03/31.
//

import Foundation

enum ResultEqualPasswordChecking {
    case blank
    case equal
    case notEqual
}

enum ResultNameChecking {
    case blank
    case correct
}

enum ResultPasswordChecking {
    case blank
    case outOfCharacterLimit
    case notIncludeUppercaseLetter
    case notIncludeDigit
    case notIncludeSpecialCharacter
    case correct
}

enum ResultIDChecking {
    case blank
    case existID
    case incorrectID
    case correct
}

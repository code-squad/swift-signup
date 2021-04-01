//
//  SignUpTextField.swift
//  SignUp
//
//  Created by 이다훈 on 2021/04/01.
//
import Foundation
import UIKit

enum TextFieldType {
    case id
    case pw
    case pw2
    case name
}

enum TextFormError {
    case ok
    case wrong(_ field: WrongType)
    case none
    
    enum WrongType {
        case idIneligible
        case idUsed
        case pwOutOfIndex
        case pwNoUpperCase
        case pwNoNumber
        case pwNoSpecialCharacter
    }
}

class SignUpTextField: UITextField {
    var relatedLabel : UILabel?
    var textFieldType : TextFieldType?
    var errorType : TextFormError = .none
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

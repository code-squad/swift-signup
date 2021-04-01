//
//  SignUpTextField.swift
//  SignUp
//
//  Created by 이다훈 on 2021/04/01.
//
import Foundation
import UIKit

enum TextFieldType : Int {
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
        case nameIsNil
        case pwDifferent
    }
}

class SignUpTextField: UITextField {
    var relatedLabel : UILabel?
    var textFieldType : TextFieldType?
    var errorType : TextFormError = .none
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.borderStyle = .line
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.borderStyle = .line
    }
    
    func changeStyle(with error : TextFormError ) {
        guard let type = self.textFieldType else {
            return
        }
        
        guard let label = relatedLabel else {
            return
        }
        
        DispatchQueue.main.async {
            label.showMessage(type: type, error: error)
            switch error {
            case .ok:
                self.changeBorder(color: UIColor.green.cgColor)
                label.isHidden = false
                label.textColor = UIColor.green
            case .wrong:
                self.changeBorder(color: UIColor.red.cgColor)
                label.isHidden = false
                label.textColor = UIColor.red
            default:
                return
            }
        }
    }
    
}

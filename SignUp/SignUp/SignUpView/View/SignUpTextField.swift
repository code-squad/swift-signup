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

class SignUpTextField: UITextField {
    var relatedLabel : UILabel?
    var textFieldType : TextFieldType?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.borderStyle = .line
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.borderStyle = .line
    }
    
    func changeStyle(with error : ErrorCheckResult ) {
        guard let label = relatedLabel else {
            return
        }
        
        DispatchQueue.main.async {
            let color = error.errorColor()
            self.changeBorder(color: color.cgColor)
            label.isHidden = false
            label.textColor = color
            label.text = error.message
        }
    }
    
}

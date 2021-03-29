//
//  SignUpTextField.swift
//  signup
//
//  Created by Song on 2021/03/29.
//

import UIKit

@IBDesignable
class SignUpTextField: UITextField {

    @IBInspectable var borderColor: UIColor = .black {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var sidePadding: CGFloat = 10 {
        didSet {
            leftView = UIView(frame: CGRect(x: 0, y: 0, width: sidePadding, height: frame.height))
            leftViewMode = .always
            
            rightView = UIView(frame: CGRect(x: 0, y: 0, width: sidePadding, height: frame.height))
            rightViewMode = .always
        }
    }
}

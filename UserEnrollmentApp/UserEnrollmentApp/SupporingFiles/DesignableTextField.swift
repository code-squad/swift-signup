//
//  IDTextField.swift
//  UserEnrollmentApp
//
//  Created by 조중윤 on 2021/03/29.
//

import UIKit

@IBDesignable
class DesignableTextField: UITextField {
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    var isValid: Bool = false
    
    func setBorderColor(wasValidInput: Bool) {
        if wasValidInput {
            self.layer.borderColor = UIColor.systemGreen.cgColor
        } else {
            self.layer.borderColor = UIColor.systemRed.cgColor
        }
    }
}

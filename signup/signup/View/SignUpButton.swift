//
//  SignUpButton.swift
//  signup
//
//  Created by Song on 2021/03/29.
//

import UIKit

@IBDesignable
class SignUpButton: UIButton {

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
    
    func configureColors() {
        setTitleColor(ColorSet.PointGreen, for: .normal)
        setTitleColor(ColorSet.PointGrey, for: .disabled)
    }
    
    func disable() {
        isEnabled = false
        tintColor = ColorSet.PointGrey
    }
    
    func enable() {
        isEnabled = true
        tintColor = ColorSet.PointGreen
    }
}

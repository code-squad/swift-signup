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
        setTitleColor(UIColor(named: "PointGreen"), for: .normal)
        setTitleColor(UIColor(named: "PointGrey"), for: .disabled)
    }
    
    func disable() {
        isEnabled = false
        tintColor = UIColor(named: "PointGrey")
    }
    
    func enable() {
        isEnabled = true
        tintColor = UIColor(named: "PointGreen")
    }
}

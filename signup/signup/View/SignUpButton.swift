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
}

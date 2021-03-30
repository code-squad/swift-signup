//
//  UITextField+Extension.swift
//  SignUp
//
//  Created by 이다훈 on 2021/03/29.
//

import UIKit

extension UITextField {
    func changeBorderColor(color : CGColor) {
        self.layer.borderWidth = 1
        self.layer.borderColor = color
    }
}

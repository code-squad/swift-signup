//
//  InputTextField.swift
//  SignUp
//
//  Created by HOONHA CHOI on 2021/03/30.
//

import UIKit

class InputTextField: UITextField {
        
    func fail() {
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 1
    }
    
    func succeed() {
        self.layer.borderColor = nil
        self.layer.borderWidth = 0
    }
}

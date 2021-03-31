//
//  SignUpStackView.swift
//  SignUp
//
//  Created by HOONHA CHOI on 2021/03/31.
//

import UIKit

class SignUpStackView : UIStackView {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var validLabel: UILabel!
    
    
    func succeed() {
        textField.layer.borderColor = nil
        textField.layer.borderWidth = 0
        validLabel.textColor = .systemGreen
    }
    
    func fail() {
        textField.layer.borderColor = UIColor.red.cgColor
        textField.layer.borderWidth = 1
        validLabel.textColor = .red
    }

    func setText(_ text : String) {
        validLabel.text = text
    }
}

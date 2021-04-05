//
//  PasswordConfirmView.swift
//  SignUp
//
//  Created by Ador on 2021/04/03.
//

import UIKit

class PasswordConfirmView: UIStackView, SignUpView {
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var message: UILabel!
    
    var label: UILabel {
        get {
            return message
        }
        set {
            message = newValue
        }
    }
    
    var field: UITextField {
        get {
            return input
        }
        set {
            input = newValue
        }
    }
}

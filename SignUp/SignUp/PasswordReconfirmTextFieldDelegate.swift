//
//  PWRTextFieldDelegate.swift
//  SignUp
//
//  Created by 양준혁 on 2021/03/30.
//

import UIKit

class PasswordReconfirmTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    private var passwordReconfirmLabel: UILabel
    var checker: (() -> Bool)
    
    init(label: UILabel, checker: @escaping () -> Bool ) {
        self.passwordReconfirmLabel = label
        self.checker = checker
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.blue.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard textField.text != nil else { return }
        if checker() {
            textField.layer.borderColor = #colorLiteral(red: 0.1540483236, green: 0.6966413856, blue: 0.1375852525, alpha: 1)
            passwordReconfirmLabel.text = "비밀번호가 일치합니다."
            passwordReconfirmLabel.textColor = #colorLiteral(red: 0.1540483236, green: 0.6966413856, blue: 0.1375852525, alpha: 1)
        } else {
            textField.layer.borderColor = #colorLiteral(red: 0.9967475533, green: 0.03828956559, blue: 0.05758263916, alpha: 1)
            passwordReconfirmLabel.text = "비밀번호가 일치하지 않습니다."
            passwordReconfirmLabel.textColor = #colorLiteral(red: 0.9967475533, green: 0.03828956559, blue: 0.05758263916, alpha: 1)
        }
    }
}

enum PasswordReconfirmState {
    case correct, incorrect
}

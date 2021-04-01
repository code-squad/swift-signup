//
//  IDTextFieldDelegate.swift
//  SignUp
//
//  Created by 양준혁 on 2021/03/29.
//

import UIKit

class IDTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    private var IDLabel: UILabel!
    private var IdChecker: IDChecker
    
    init(label: UILabel) {
        IDLabel = label
        self.IdChecker = IDChecker()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.blue.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        IdChecker.check(text: text) { (state) in
            self.updateLabel(state: state, label: self.IDLabel, textField: textField)
        }
    }
    
    func updateLabel(state: IDTextFieldState, label: UILabel, textField: UITextField) {
        switch state {
        case .alreadyUse:
            label.text = "이미 사용중인 아이디입니다."
            label.textColor = #colorLiteral(red: 0.9967475533, green: 0.03828956559, blue: 0.05758263916, alpha: 1)
            textField.layer.borderColor = #colorLiteral(red: 0.9967475533, green: 0.03828956559, blue: 0.05758263916, alpha: 1)
        case .correct:
            label.text = "사용 가능합니다."
            label.textColor = #colorLiteral(red: 0.1540483236, green: 0.6966413856, blue: 0.1375852525, alpha: 1)
            textField.layer.borderColor = #colorLiteral(red: 0.1540483236, green: 0.6966413856, blue: 0.1375852525, alpha: 1)
        case .incorrect:
            label.text = "5~20자의 영문 소문자, 숫자와 특수기호(_)(-) 만 사용 가능합니다."
            label.textColor = #colorLiteral(red: 0.9967475533, green: 0.03828956559, blue: 0.05758263916, alpha: 1)
            textField.layer.borderColor = #colorLiteral(red: 0.9967475533, green: 0.03828956559, blue: 0.05758263916, alpha: 1)
        }
    }
}

enum IDTextFieldState {
    case incorrect, correct, alreadyUse
}

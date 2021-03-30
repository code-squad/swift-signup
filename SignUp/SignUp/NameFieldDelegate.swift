//
//  NameFieldDelegate.swift
//  SignUp
//
//  Created by Ador on 2021/03/30.
//

import UIKit

class NameFieldDelegate: NSObject, UITextFieldDelegate {
    var updateLabelHandler: (((NameCheck, UIColor?)) -> Void)?
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 0
        guard let text = textField.text?.replacingOccurrences(of: " ", with: ""), !text.isEmpty else {
            updateLabelHandler?((.empty, .systemRed))
            return
        }
        updateLabelHandler?((.notEmpty, nil))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

enum NameCheck: String {
    case empty = "이름은 필수 입력 항목입니다."
    case notEmpty = ""
}

//
//  NameTextFieldDelegate.swift
//  SignupApp
//
//  Created by Song on 2021/03/31.
//

import UIKit

class NameTextFieldDelegate: NSObject, UITextFieldDelegate {
    private let validName: () -> ()
    private let invalidName: () -> ()
    var validated: Bool = false
    
    init(validName: @escaping () -> (), invalidName: @escaping () -> ()) {
        self.validName = validName
        self.invalidName = invalidName
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let name = textField.text else { return }
        validated = validate(text: name)
        NotificationCenter.default.post(name: NotificationName.DidChangeValidation, object: validated)
    }
    
    func validate(text: String) -> Bool {
        if text.isEmpty {
            invalidName()
            return false
        } else {
            validName()
            return true
        }
    }
}

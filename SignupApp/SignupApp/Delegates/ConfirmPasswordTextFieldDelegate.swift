//
//  ConfirmPasswordTextFieldDelegate.swift
//  SignupApp
//
//  Created by Song on 2021/03/31.
//

import UIKit

class ConfirmPasswordTextFieldDelegate: NSObject, UITextFieldDelegate {
    private var password: String = ""
    private let validConfirmPassword: () -> ()
    private let invalidConfirmPassword: () -> ()
    var validated: Bool = false
    
    init(validConfirmPassword: @escaping () -> (), invalidConfirmPassword: @escaping () -> ()) {
        self.validConfirmPassword = validConfirmPassword
        self.invalidConfirmPassword = invalidConfirmPassword
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(onDidChangePassword(_:)), name: NotificationName.DidChangePassword, object: nil)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let confirmPassword = textField.text else { return }
        validated = validate(text: confirmPassword)
        NotificationCenter.default.post(name: NotificationName.DidChangeValidation, object: validated)
    }
    
    func validate(text: String) -> Bool {
        if password == text {
            validConfirmPassword()
            return true
        } else {
            invalidConfirmPassword()
            return false
        }
    }
    
    @objc func onDidChangePassword(_ notification: Notification) {
        guard let updatedPassword: String = notification.userInfo?[K.userInfoKey] as? String else { return }
        self.password = updatedPassword
    }
}

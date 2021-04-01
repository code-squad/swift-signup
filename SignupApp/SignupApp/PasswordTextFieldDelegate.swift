//
//  PasswordTextFieldDelegate.swift
//  SignupApp
//
//  Created by Song on 2021/03/31.
//

import UIKit

class PasswordTextFieldDelegate: NSObject, UITextFieldDelegate {
    //enum Notification {
    //    static let DidChangePassword = Foundation.Notification.Name("DidChangePassword")
    //}
    private let validationManager = ValidationManager()
    private let invalidPasswordLength: () -> ()
    private let noUppercasePassword: () -> ()
    private let noDigitPassword: () -> ()
    private let noSpecialCharacterPassword: () -> ()
    private let validPassword: () -> ()
    var validated: Bool = false
    
    init(invalidPasswordLength: @escaping () -> (), noUppercasePassword: @escaping () -> (), noDigitPassword: @escaping () -> (), noSpecialCharacterPassword: @escaping () -> (), validPassword: @escaping () -> ()) {
        self.invalidPasswordLength = invalidPasswordLength
        self.noUppercasePassword = noUppercasePassword
        self.noDigitPassword = noDigitPassword
        self.noSpecialCharacterPassword = noSpecialCharacterPassword
        self.validPassword = validPassword
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let password = textField.text else { return }
        let userInfo: [AnyHashable: String] = [K.userInfoKey: password]
        NotificationCenter.default.post(name: NotificationName.DidChangePassword, object: textField.text, userInfo: userInfo)
        validated = validate(text: password)
        NotificationCenter.default.post(name: NotificationName.DidChangeValidation, object: validated)
    }
    
    func validate(text: String) -> Bool {
        if !validationManager.isSatisfiedLength(password: text) {
            invalidPasswordLength()
            return false
        } else if !validationManager.hasUppercase(password: text) {
            noUppercasePassword()
            return false
        } else if !validationManager.hasDigit(password: text) {
            noDigitPassword()
            return false
        } else if !validationManager.hasSpecialCharacter(password: text) {
            noSpecialCharacterPassword()
            return false
        } else if validationManager.isAvailable(password: text) {
            validPassword()
            return true
        }
        return false
    }
}

//
//  BasicInfomationTextFieldViewModel.swift
//  SignupApp
//
//  Created by Issac on 2021/03/31.
//

import UIKit
import Combine

class BasicInfomationTextFieldViewModel: NSObject {
    @IBOutlet weak var IDField: CustomTextField!
    @IBOutlet weak var passwordField: CustomTextField!
    @IBOutlet weak var checkPasswordField: CustomTextField!
    @IBOutlet weak var nameField: CustomTextField!
    
    typealias ResultValidate = (ID: ResultIDChecking,
                                password: ResultPasswordChecking,
                                equalPassword: ResultEqualPasswordChecking,
                                name: ResultNameChecking)
    
    private var resultHandler: (ResultValidate) -> ()
    
    @IBOutlet var textFields: [CustomTextField]!
    
    let validator: TextValidator
    
    override init() {
        self.resultHandler = { _ in }
        self.validator = TextValidator()
        super.init()
        
    }
    
    @objc func changeFieldStyle() {
        let IDText = self.IDField.text ?? ""
        let passwordText = self.passwordField.text ?? ""
        let checkPasswordText = self.checkPasswordField.text ?? ""
        let nameText = self.nameField.text ?? ""

        let result: ResultValidate = (validator.checkID(of: IDText),
                                      validator.checkPassword(of: passwordText),
                                      validator.checkEqualPassword(of: checkPasswordText, anotherPassword: passwordText),
                                      validator.checkFillNameIn(name: nameText, anotherText: [IDText, passwordText, checkPasswordText]))

        self.resultHandler((result.ID,
                            result.password,
                            result.equalPassword,
                            result.name))

        self.changeIDStyle(caseOf: result.ID)
        self.changePasswordStyle(caseOf: result.password)
        self.changeEqualPasswordStyle(caseOf: result.equalPassword)
        self.changeNameStyle(caseOf: result.name)
    }
    
    func initTarget() {
        self.IDField.addTarget(self, action: #selector(changeFieldStyle), for: .editingDidEnd)
        self.passwordField.addTarget(self, action: #selector(changeFieldStyle), for: .editingDidEnd)
        self.checkPasswordField.addTarget(self, action: #selector(changeFieldStyle), for: .editingDidEnd)
        self.nameField.addTarget(self, action: #selector(changeFieldStyle), for: .editingDidEnd)
    }
    
    func bind(present action: @escaping (ResultValidate) -> ()) {
        self.resultHandler = action
    }
}

extension BasicInfomationTextFieldViewModel: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let textField = textField as? CustomTextField else { return }
        textField.typingStyle()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let textField = textField as? CustomTextField {
            if textField == nameField && nameField.text == "" {
                textField.failorStyle()
            } else {
                textField.defaultStyle()
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let customTextField = textField as? CustomTextField else { return false }
        guard let index = textFields.firstIndex(of: customTextField) else { return false }
        if index < textFields.count - 1 {
            textFields[index + 1].becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.passwordField || textField == checkPasswordField {
            textField.textContentType = .oneTimeCode
        }
        return true
    }
    
//    func textFieldDidChangeSelection(_ textField: UITextField) {
//        for textField in textFields {
//            if textField.text == "" || textField.layer.borderColor == #colorLiteral(red: 0.7830513277, green: 0.2840242443, blue: 0.3156971657, alpha: 1) {
//                self.nextButton.isEnabled = false
//                return
//            }
//        }
//        self.nextButton.isEnabled = true
//    }
}

extension BasicInfomationTextFieldViewModel {
    private func changeIDStyle(caseOf result: ResultIDChecking) {
        switch result {
        case .existID, .incorrectID:
            incorrectStyle(of: self.IDField)
        case .blank, .correct:
            defaultStyle(of: self.IDField)
        }
    }
    
    private func changePasswordStyle(caseOf result: ResultPasswordChecking) {
        switch result {
        case .notIncludeDigit, .notIncludeSpecialCharacter, .notIncludeUppercaseLetter, .outOfCharacterLimit:
            incorrectStyle(of: self.passwordField)
        case .blank, .correct:
            defaultStyle(of: self.passwordField)
        }
    }
    
    private func changeEqualPasswordStyle(caseOf result: ResultEqualPasswordChecking) {
        switch result {
        case .notEqual:
            incorrectStyle(of: self.checkPasswordField)
        case .blank, .equal:
            defaultStyle(of: self.checkPasswordField)
        }
    }
    
    private func changeNameStyle(caseOf result: ResultNameChecking) {
        switch result {
        case .blank:
            incorrectStyle(of: self.nameField)
        case .correct:
            defaultStyle(of: self.nameField)
        }
    }
    
    //MARK:Style
    private func incorrectStyle(of textField: UITextField) {
        guard let textField = textField as? CustomTextField else { return }
        textField.failorStyle()
    }
    
    private func defaultStyle(of textField: UITextField) {
        guard let textField = textField as? CustomTextField else { return }
        textField.defaultStyle()
    }
}

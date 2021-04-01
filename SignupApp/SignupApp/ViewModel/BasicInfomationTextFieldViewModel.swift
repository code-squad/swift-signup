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
                                      validator.checkEqualPassword(of: passwordText, anotherPassword: checkPasswordText),
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
        textField.layer.borderColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        textField.layer.borderWidth = 1
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
            break
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
        textField.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        textField.layer.borderWidth = 1
    }
    
    private func defaultStyle(of textField: UITextField) {
        textField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        textField.layer.borderWidth = 1
    }
}

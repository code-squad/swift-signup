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
    
    typealias ResultTextfieldValidate = (ID: ResultIDChecking,
                                         password: ResultPasswordChecking,
                                         equalPassword: ResultEqualPasswordChecking,
                                         name: ResultNameChecking)
    
    private var resultHandler: (ResultTextfieldValidate) -> ()
    
    @IBOutlet var textFields: [CustomTextField]!
    
    var existIDs = [String]()
    
    override init() {
        self.resultHandler = { _ in }
        
        super.init()

        //MARK:서버의 부담을 막기 위해 load 시 한 번만 불러오도록 함
        let url = URL(string: "https://8r6ruzgzve.execute-api.ap-northeast-2.amazonaws.com/default/SwiftCamp")!
        NetworkCenter.shared.receiveIDList(url: url) { (existIDs) in
            //JSON을 따로 처리해보기!!!!!!!
            self.existIDs = existIDs
        }
    }
    
    @objc func changeFieldStyle() {
        let result: ResultTextfieldValidate = (self.checkID(),
                                               self.checkPassword(),
                                               self.checkEqualPassword(),
                                               self.checkFillNameIn())
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
    
    func bind(present action: @escaping (ResultTextfieldValidate) -> ()) {
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
    //MARK:Validation
    private func checkFillNameIn() -> ResultNameChecking {
        return self.nameField.text == ""
            && textFields.filter({ $0.text == "" }) == [nameField]
            ? .blank
            : .correct
    }
    
    private func checkEqualPassword() -> ResultEqualPasswordChecking {
        let checkPassword = self.checkPasswordField.text ?? ""
        switch checkPassword {
        case "": return .blank
        case _ where checkPassword == self.passwordField.text ?? "": return .equal
        default: return .notEqual
        }
    }
    
    private func checkPassword() -> ResultPasswordChecking {
        let password = passwordField.text ?? ""
        switch password {
        case "": return .blank
        case _ where isOutOfCharacterLimitPassword(of: password): return .outOfCharacterLimit
        case _ where isNotIncludeUppercaseLetter(of: password): return .notIncludeUppercaseLetter
        case _ where isNotIncludeDigit(of: password): return .notIncludeDigit
        case _ where isNotIncludeSpecialCharacter(of: password): return .notIncludeSpecialCharacter
        default: return .correct
        }
    }
    
    private func checkID() -> ResultIDChecking {
        let ID = IDField.text ?? ""
        switch ID {
        case "" : return .blank
        case _ where isExistID(ID: ID): return .existID
        case _ where isIncorrectID(ID: ID): return .incorrectID
        default: return .correct
        }
    }
    
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
    
    //MARK:Regex
    private func isOutOfCharacterLimitPassword(of password: String) -> Bool {
        return !password.match(for: "^.{8,16}$")
    }

    private func isNotIncludeUppercaseLetter(of password: String) -> Bool {
        return !password.match(for: "^.*[A-Z]{1,}.*$")
    }

    private func isNotIncludeDigit(of password: String) -> Bool {
        return !password.match(for: "^.*[\\d]+.*$")
    }

    private func isNotIncludeSpecialCharacter(of password: String) -> Bool {
        return !password.match(for: "^.*[\\!\\@\\#\\$\\%]+.*$")
    }

    private func isExistID(ID: String) -> Bool {
        return self.existIDs.contains(ID)
    }

    private func isIncorrectID(ID: String) -> Bool {
        return !ID.match(for: "^[a-z\\d\\-\\_]{5,20}$")
    }
}

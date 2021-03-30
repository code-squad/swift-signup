//
//  ViewController.swift
//  SignupApp
//
//  Created by Issac on 2021/03/29.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    enum LabelMessage {
        static let correctID = "사용 가능한 아이디입니다."
        static let existedID = "이미 사용중인 아이디입니다."
        static let incorrectID = "5~20자의 영문 소문자, 숫자와 특수기호(_)(-)만 사용 가능합니다."
        static let outOfCharacterLimitPassword = "8자 이상 16자 이하로 입력해주세요."
        static let requireMinimumDigit = "숫자를 최소 1자 이상 포함해주세요."
        static let requireMinimumUpperCase = "영문 대문자를 최소 1자 이상 포함해주세요."
        static let requireMinimumSpecialCharacter = "특수문자를 최소 1자 이상 포함해주세요."
        static let correctPassword = "안전한 비밀번호입니다."
        static let equalPassword = "비밀번호가 일치합니다."
        static let notEqualPassword = "비밀번호가 일치하지 않습니다."
        static let requireFillNameIn = "이름은 필수 입력 항목입니다."
    }
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var IDField: CustomTextField!
    @IBOutlet weak var passwordField: CustomTextField!
    @IBOutlet weak var checkPasswordField: CustomTextField!
    @IBOutlet weak var nameField: CustomTextField!
    
    @IBOutlet weak var IDMessageLabel: UILabel!
    @IBOutlet weak var passwordMessageLabel: UILabel!
    @IBOutlet weak var checkPasswordMessageLabel: UILabel!
    @IBOutlet weak var nameMessageLabel: UILabel!
     
    @IBOutlet var textFields: [CustomTextField]!
    @IBOutlet var messageLabel: [UILabel]!
    
    var existIDs = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFields.forEach { (textField) in
            textField.delegate = self
        }
        
        //MARK:서버의 부담을 막기 위해 load 시 한 번만 불러오도록 함
        let url = URL(string: "https://8r6ruzgzve.execute-api.ap-northeast-2.amazonaws.com/default/SwiftCamp")!
        NetworkCenter().receiveIDList(url: url) { (existIDs) in
            self.existIDs = existIDs
        }
        
        IDField.addTarget(self, action: #selector(checkID), for: [.editingChanged, .editingDidEnd
        ])
        passwordField.addTarget(self, action: #selector(checkPassword), for: [.editingChanged, .editingDidEnd
        ])
        checkPasswordField.addTarget(self, action: #selector(checkEqualPassword), for: [.editingChanged, .editingDidEnd
                                     ])
        nameField.addTarget(self, action: #selector(checkFillNameIn), for: [.editingChanged, .editingDidEnd])
        
    }
    @objc private func checkFillNameIn() {
        if self.nameField.text != "" {
            self.nameMessageLabel.text = ""
            self.nameField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        } else {
            self.nameMessageLabel.text = LabelMessage.requireFillNameIn
            changeStyleToCorrect(label: self.nameMessageLabel, textField: self.nameField, correct: false)
        }
    }
    
    @objc private func checkEqualPassword() {
        let checkPassword = self.checkPasswordField.text ?? ""
        switch checkPassword {
        case "":
            self.nameMessageLabel.text = ""
            self.checkPasswordField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case _ where checkPassword == self.passwordField.text ?? "":
            self.checkPasswordMessageLabel.text = LabelMessage.equalPassword
            changeStyleToCorrect(label: self.checkPasswordMessageLabel, textField: self.checkPasswordField, correct: true)
        default:
            self.checkPasswordMessageLabel.text = LabelMessage.notEqualPassword
            changeStyleToCorrect(label: self.checkPasswordMessageLabel, textField: self.checkPasswordField, correct: false)
        }
    }
    
    @objc private func checkPassword() {
        let password = passwordField.text ?? ""
        switch password {
        case "":
            self.passwordField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.passwordMessageLabel.text = ""
        case _ where isOutOfCharacterLimitPassword(of: password):
            self.passwordMessageLabel.text = LabelMessage.outOfCharacterLimitPassword
            changeStyleToCorrect(label: self.passwordMessageLabel, textField: self.passwordField, correct: false)
        case _ where isNotIncludeUppercaseLetter(of: password):
            self.passwordMessageLabel.text = LabelMessage.requireMinimumUpperCase
            changeStyleToCorrect(label: self.passwordMessageLabel, textField: self.passwordField, correct: false)
        case _ where isNotIncludeDigit(of: password):
            self.passwordMessageLabel.text = LabelMessage.requireMinimumDigit
            changeStyleToCorrect(label: self.passwordMessageLabel, textField: self.passwordField, correct: false)
        case _ where isNotIncludeSpecialCharacter(of: password):
            self.passwordMessageLabel.text = LabelMessage.requireMinimumSpecialCharacter
            changeStyleToCorrect(label: self.passwordMessageLabel, textField: self.passwordField, correct: false)
        default:
            self.passwordMessageLabel.text = LabelMessage.correctPassword
            changeStyleToCorrect(label: self.passwordMessageLabel, textField: self.passwordField, correct: true)
        }
    }
    
    @objc private func checkID() {
        let ID = IDField.text ?? ""
        switch ID {
        case "":
            self.IDField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.IDMessageLabel.text = ""
        case _ where isExistID(ID: ID):
            self.IDMessageLabel.text = LabelMessage.existedID
            changeStyleToCorrect(label: self.IDMessageLabel, textField: self.IDField, correct: false)
        case _ where isIncorrectID(ID: ID):
            self.IDMessageLabel.text = LabelMessage.incorrectID
            changeStyleToCorrect(label: self.IDMessageLabel, textField: self.IDField, correct: false)
        default:
            self.IDMessageLabel.text = LabelMessage.correctID
            changeStyleToCorrect(label: self.IDMessageLabel, textField: self.IDField, correct: true)
        }
    }
    
    //MARK: textField Delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        for textField in textFields {
            if textField.text == "" || textField.layer.borderColor == #colorLiteral(red: 0.7830513277, green: 0.2840242443, blue: 0.3156971657, alpha: 1) {
                self.nextButton.isEnabled = false
                return
            }
        }
        self.nextButton.isEnabled = true
    }
}


extension ViewController {
    private func changeStyleToCorrect(label: UILabel, textField: UITextField, correct: Bool) {
        if correct {
            label.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            textField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        } else {
            label.textColor = #colorLiteral(red: 0.7830513277, green: 0.2840242443, blue: 0.3156971657, alpha: 1)
            textField.layer.borderColor = #colorLiteral(red: 0.7830513277, green: 0.2840242443, blue: 0.3156971657, alpha: 1)
        }
    }
    
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

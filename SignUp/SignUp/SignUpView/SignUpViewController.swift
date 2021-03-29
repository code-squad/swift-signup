//
//  ViewController.swift
//  SignUp
//
//  Created by 이다훈 on 2021/03/29.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet var categoryLabelCollection: [UILabel]!
    @IBOutlet var textFieldCollection: [UITextField]!
    @IBOutlet var informationLabelCollection: [UILabel]!
    
    private let textFieldDelegate = TextFieldDelegate()
    private let complianceChecker = ComplianceChecker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCategorylabel()
        configureTextField()
        configureInformationLabel()
        configureObserver()
    }

    private func configureCategorylabel() {
        for label in categoryLabelCollection {
            label.font = .boldSystemFont(ofSize: 17)
        }
    }
    
    private func configureTextField() {
        for textfield in textFieldCollection {
            textfield.borderStyle = .line
            textfield.delegate = textFieldDelegate
            
            let identifier = textfield.accessibilityIdentifier ?? ""
            if identifier == "PWTextField" ||
               identifier == "PW2TextField" {
                textfield.isSecureTextEntry = true
            }
        }
    }
    
    private func configureInformationLabel() {
        for label in informationLabelCollection {
            label.font = .systemFont(ofSize: 12)
            label.isHidden = true
            label.adjustsFontSizeToFitWidth = true
        }
    }

    private func configureObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(idTextFieldEdited(_:)), name: .idTextField, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(pwTextFieldEdited(_:)), name: .pwTextField, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(pw2TextFieldEdited(_:)), name: .pw2TextField, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(nameTextFieldEdited(_:)), name: .nameTextField, object: nil)
    }
    
    
    @objc private func idTextFieldEdited(_ notification : Notification) {
        let textField = notification.object as! UITextField
        guard let text = textField.text else {
            return
        }
        
        guard let label = informationLabelCollection.first(where: { label in
            label.accessibilityIdentifier ?? "" == "IDInformation"
        })  else {
            return
        }
        
        label.isHidden = false
        
        switch complianceChecker.checkIdTextForm(with: text) {
        case .ok:
            textField.changeBorderColor(color: UIColor.green.cgColor)
            label.changeTextNColor(color: UIColor.green, text: "사용 가능한 아이디입니다.")
        case .used:
            textField.changeBorderColor(color: UIColor.red.cgColor)
            label.changeTextNColor(color: UIColor.red, text: "이미 사용중인 아이디입니다.")
        case .wrong:
            textField.changeBorderColor(color: UIColor.red.cgColor)
            label.changeTextNColor(color: UIColor.red, text: "5~20자의 영문 소문자, 숫자와 특수기호(_,-)만 사용 가능합니다.")
        }
    }
    
    @objc private func pwTextFieldEdited(_ notification : Notification) {
        let textField = notification.object as! UITextField
        guard let text = textField.text else {
            return
        }
        
        guard let label = informationLabelCollection.first(where: { label in
            label.accessibilityIdentifier ?? "" == "PWInformation"
        })  else {
            return
        }
        
        label.isHidden = false
    }
    
    @objc private func pw2TextFieldEdited(_ notification : Notification) {
        let textField = notification.object as! UITextField
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.red.cgColor
    }
    
    @objc private func nameTextFieldEdited(_ notification : Notification) {
        let textField = notification.object as! UITextField
        guard let text = textField.text else {
            return
        }
        let nameTextFormFlag : nameTextFormError = text == "" ? .wrong : .ok
        
        guard let label = informationLabelCollection.first(where: { label in
            label.accessibilityIdentifier ?? "" == "NameInformation"
        })  else {
            return
        }
        
        switch nameTextFormFlag {
        case .ok:
            label.isHidden = true
            textField.changeBorderColor(color: UIColor.black.cgColor)
        case .wrong:
            label.isHidden = false
            textField.changeBorderColor(color: UIColor.red.cgColor)
            label.changeTextNColor(color: UIColor.red, text: "이름은 필수 입력 항목입니다.")
        }
    }
}


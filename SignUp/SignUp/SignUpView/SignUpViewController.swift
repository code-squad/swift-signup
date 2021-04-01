//
//  ViewController.swift
//  SignUp
//
//  Created by 이다훈 on 2021/03/29.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet var categoryLabelCollection: [UILabel]!
    @IBOutlet var textFieldCollection: [SignUpTextField]!
    @IBOutlet var informationLabelCollection: [UILabel]!
    
    private let textFieldDelegate = TextFieldDelegate()
    private let complianceChecker = ComplianceChecker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField()
        configureObserver()
    }
    
    private func configureTextField() {
        for index in 0..<textFieldCollection.count {
            textFieldCollection[index].textFieldType = TextFieldType(rawValue: index)
            textFieldCollection[index].delegate = textFieldDelegate
            textFieldCollection[index].relatedLabel = informationLabelCollection[index]
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
        
        complianceChecker.checkIdTextForm(with: text, closure : { usedCheck in
            DispatchQueue.main.async {
                label.isHidden = false
                switch usedCheck {
                case .ok:
                    textField.changeBorder(color: UIColor.green.cgColor)
                    label.changeStyle(color: UIColor.green, text: "사용 가능한 아이디입니다.")
                case .used:
                    textField.changeBorder(color: UIColor.red.cgColor)
                    label.changeStyle(color: UIColor.red, text: "이미 사용중인 아이디입니다.")
                case .wrong:
                    textField.changeBorder(color: UIColor.red.cgColor)
                    label.changeStyle(color: UIColor.red, text: "5~20자의 영문 소문자, 숫자와 특수기호(_,-)만 사용 가능합니다.")
                case .none:
                    return
                }
            }
            })
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
        
        switch complianceChecker.checkPwTextForm(with: text) {
        case .ok:
            textField.changeBorder(color: UIColor.green.cgColor)
            label.changeStyle(color: UIColor.green, text: "안전한 비밀번호입니다.")
            
        case .outOfIndex:
            textField.changeBorder(color: UIColor.red.cgColor)
            label.changeStyle(color: UIColor.red, text: "8자 이상 16자 이하로 입력해주세요.")
            
        case .noUpperCase:
            textField.changeBorder(color: UIColor.red.cgColor)
            label.changeStyle(color: UIColor.red, text: "영문 대문자를 최소 1자 이상 포함해주세요.")
        
        case .noNumber:
            textField.changeBorder(color: UIColor.red.cgColor)
            label.changeStyle(color: UIColor.red, text: "숫자를 최소 1자 이상 포함해주세요.")
        
        case .noSpecialCharacter:
            textField.changeBorder(color: UIColor.red.cgColor)
            label.changeStyle(color: UIColor.red, text: "특수문자를 최소 1자 이상 포함해주세요.")
        }
        
    }
    
    @objc private func pw2TextFieldEdited(_ notification : Notification) {
        let textField = notification.object as! UITextField
        guard let text = textField.text else {
            return
        }
        
        guard let pwTextField = textFieldCollection.first(where: {textField in
            textField.accessibilityIdentifier ?? "" == "PWTextField"
        }) else {
            return
        }
        
        guard let label = informationLabelCollection.first(where: { label in
            label.accessibilityIdentifier ?? "" == "PW2Information"
        })  else {
            return
        }
        
        let pwCoincidenceCheck : CoincidenceError = text == pwTextField.text ? .ok : .wrong
        
        label.isHidden = false
        
        switch pwCoincidenceCheck {
        case .ok:
            textField.changeBorder(color: UIColor.green.cgColor)
            label.changeStyle(color: UIColor.green, text: "비밀번호가 일치합니다.")
        case .wrong:
            textField.changeBorder(color: UIColor.red.cgColor)
            label.changeStyle(color: UIColor.red, text: "비밀번호가 일치하지 않습니다..")
        }
    }
    
    @objc private func nameTextFieldEdited(_ notification : Notification) {
        let textField = notification.object as! UITextField
        guard let text = textField.text else {
            return
        }
        let nameTextNilCheck : CoincidenceError = text == "" ? .wrong : .ok
        
        guard let label = informationLabelCollection.first(where: { label in
            label.accessibilityIdentifier ?? "" == "NameInformation"
        })  else {
            return
        }
        
        switch nameTextNilCheck {
        case .ok:
            label.isHidden = true
            textField.changeBorder(color: UIColor.black.cgColor)
        case .wrong:
            label.isHidden = false
            textField.changeBorder(color: UIColor.red.cgColor)
            label.changeStyle(color: UIColor.red, text: "이름은 필수 입력 항목입니다.")
        }
    }
    
    @IBAction func nextButtonTouched(_ sender: Any) {
        //nextView
    }
}


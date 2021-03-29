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
    
    let textFieldDelegate = TextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCategorylabel()
        configureTextField()
        configureInformationLabel()
        configureObserver()
    }

    func configureCategorylabel() {
        for label in categoryLabelCollection {
            label.font = .boldSystemFont(ofSize: 17)
        }
    }
    
    func configureTextField() {
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
    
    func configureInformationLabel() {
        for label in informationLabelCollection {
            label.font = .systemFont(ofSize: 12)
            label.isHidden = true
        }
    }

    func configureObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(idTextFieldEdited(_:)), name: .idTextField, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(pwTextFieldEdited(_:)), name: .pwTextField, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(pw2TextFieldEdited(_:)), name: .pw2TextField, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(nameTextFieldEdited(_:)), name: .nameTextField, object: nil)
    }
    
    @objc func idTextFieldEdited(_ notification : Notification) {
        let textField = notification.object as! UITextField
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.red.cgColor
    }
    
    @objc func pwTextFieldEdited(_ notification : Notification) {
        let textField = notification.object as! UITextField
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.red.cgColor
    }
    
    @objc func pw2TextFieldEdited(_ notification : Notification) {
        let textField = notification.object as! UITextField
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.red.cgColor
    }
    
    @objc func nameTextFieldEdited(_ notification : Notification) {
        let textField = notification.object as! UITextField
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.red.cgColor
    }
}


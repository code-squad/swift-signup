//
//  ViewController.swift
//  UserEnrollmentApp
//
//  Created by 조중윤 on 2021/03/29.
//

import UIKit

class SignUpViewController: UIViewController {
    let idFieldDelegate = SignUpSceneIdFieldDelegate()
    let passwordFieldDelegate = SignUpScenePasswordFieldDelegate()
    let passwordReconfirmFieldDelegate = SignUpScenePasswordReconfirmFieldDelegate()
    let nameFieldDelegate = SignUpSceneNameFieldDelegate()
    
    @IBOutlet weak var idTextField: DesignableTextField!
    @IBOutlet weak var passwordTextField: DesignableTextField!
    @IBOutlet weak var passwordReconfirmTextField: DesignableTextField!
    @IBOutlet weak var nameTextField: DesignableTextField!
    
    @IBOutlet weak var IDValidationResultLabel: ResultExplanationLabel!
    @IBOutlet weak var PasswordValidationResultLabel: ResultExplanationLabel!
    @IBOutlet weak var PasswordReconfirmValidationResultLabel: ResultExplanationLabel!
    @IBOutlet weak var NameValidationResultLabel: ResultExplanationLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.idTextField.delegate = idFieldDelegate
        self.passwordTextField.delegate = passwordFieldDelegate
        self.passwordReconfirmTextField.delegate = passwordReconfirmFieldDelegate
        self.nameTextField.delegate = nameFieldDelegate
        
        self.idFieldDelegate.resultNotifyingDelegate = self
        self.passwordFieldDelegate.resultNotifyingDelegate = self
    }
}

extension SignUpViewController: ResultNotifyingDelegate {
    func showValidationResult(sender: UITextFieldDelegate, result: Bool, explanation: String) {
        switch sender {
        case is SignUpSceneIdFieldDelegate:
            IDValidationResultLabel.text = explanation
            IDValidationResultLabel.setTextColor(isGoodExplanation: result)
            idTextField.setBorderColor(wasValidInput: result)
            
        case is SignUpScenePasswordFieldDelegate:
            PasswordValidationResultLabel.text = explanation
            PasswordValidationResultLabel.setTextColor(isGoodExplanation: result)
            passwordTextField.setBorderColor(wasValidInput: result)
        default: NameValidationResultLabel.text = "test2"
        }
    }
}

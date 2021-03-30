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
    
    @IBOutlet weak var IDValidationResult: ResultExplanationLabel!
    @IBOutlet weak var PasswordValidationResult: ResultExplanationLabel!
    @IBOutlet weak var PasswordReconfirmValidationResult: ResultExplanationLabel!
    @IBOutlet weak var NameValidationResult: ResultExplanationLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.idTextField.delegate = idFieldDelegate
        self.passwordTextField.delegate = passwordFieldDelegate
        self.passwordReconfirmTextField.delegate = passwordReconfirmFieldDelegate
        self.nameTextField.delegate = nameFieldDelegate
        
        //SignUp~~~인 idFieldDelegate인 의 델리깃을 self로 설정함
        self.idFieldDelegate.resultNotifyingDelegate = self
    }
}

extension SignUpViewController: ResultNotifyingDelegate {
    func showValidationResult(sender: UITextFieldDelegate, result: Bool, explanation: String) {
        switch sender {
        case is SignUpSceneIdFieldDelegate:
            IDValidationResult.text = explanation
            IDValidationResult.setTextColor(isGoodExplanation: result)
            idTextField.setBorderColor(wasValidInput: result)
        default: NameValidationResult.text = "test2"
        }
    }
}

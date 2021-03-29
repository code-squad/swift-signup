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
    
    @IBOutlet weak var IDValidationResult: UILabel!
    @IBOutlet weak var PasswordValidationResult: UILabel!
    @IBOutlet weak var PasswordReconfirmValidationResult: UILabel!
    
    @IBOutlet weak var NameValidationResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.idTextField.delegate = idFieldDelegate
        self.passwordTextField.delegate = passwordFieldDelegate
        self.passwordReconfirmTextField.delegate = passwordReconfirmFieldDelegate
        self.nameTextField.delegate = nameFieldDelegate
    }
}

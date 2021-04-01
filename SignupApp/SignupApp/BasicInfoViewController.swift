//
//  ViewController.swift
//  SignupApp
//
//  Created by Song on 2021/03/29.
//

import UIKit

class BasicInfoViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var usernameMessageLabel: UILabel!
    @IBOutlet weak var passwordMessageLabel: UILabel!
    @IBOutlet weak var confirmPasswordMessageLabel: UILabel!
    @IBOutlet weak var nameMessageLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    
    var usernameTextFieldDelegate: UsernameTextFieldDelegate?
    var passwordTextFieldDelegate: PasswordTextFieldDelegate?
    var confirmPasswordTextFieldDelegate: ConfirmPasswordTextFieldDelegate?
    var nameTextFieldDelegate: NameTextFieldDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUsernameTextField()
        configurePasswordTextField()
        configureconfirmPasswordTextField()
        configureNameTextField()
        setDefaultTextOfMessageLabels()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateButtonState), name: NotificationName.DidChangeValidation, object: nil)
        nextButton.isEnabled = false
        
        navigationController?.navigationBar.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    func configureUsernameTextField() {
        usernameTextFieldDelegate = UsernameTextFieldDelegate(
            validUsername: {
                self.usernameMessageLabel.text = K.SuccessMessage.username
                self.usernameMessageLabel.textColor = UIColor(named: K.KeyColors.greenText)
            },
            invalidUsername: {
                self.usernameMessageLabel.text = K.ErrorMessage.username
                self.usernameMessageLabel.textColor = UIColor(named: K.KeyColors.redErrorMessage)
            },
            alreadyExistingUsername: {
                self.usernameMessageLabel.text = K.ErrorMessage.alreadyExistingUsername
                self.usernameMessageLabel.textColor = UIColor(named: K.KeyColors.redErrorMessage)
            })
        usernameTextField.delegate = self.usernameTextFieldDelegate
    }
    
    func configurePasswordTextField() {
        passwordTextFieldDelegate = PasswordTextFieldDelegate(
            invalidPasswordLength: {
                self.passwordMessageLabel.text = K.ErrorMessage.passwordLength
                self.passwordMessageLabel.textColor = UIColor(named: K.KeyColors.redErrorMessage)
            },
            noUppercasePassword: {
                self.passwordMessageLabel.text = K.ErrorMessage.passwordUppercase
                self.passwordMessageLabel.textColor = UIColor(named: K.KeyColors.redErrorMessage)
            },
            noDigitPassword: {
                self.passwordMessageLabel.text = K.ErrorMessage.passwordDigit
                self.passwordMessageLabel.textColor = UIColor(named: K.KeyColors.redErrorMessage)
            },
            noSpecialCharacterPassword: {
                self.passwordMessageLabel.text = K.ErrorMessage.passwordSpecialCharacter
                self.passwordMessageLabel.textColor = UIColor(named: K.KeyColors.redErrorMessage)
            },
            validPassword: {
                self.passwordMessageLabel.text = K.SuccessMessage.password
                self.passwordMessageLabel.textColor = UIColor(named: K.KeyColors.greenText)
            })
        passwordTextField.delegate = self.passwordTextFieldDelegate
    }
    
    func configureconfirmPasswordTextField() {
        confirmPasswordTextFieldDelegate = ConfirmPasswordTextFieldDelegate(
            validConfirmPassword: {
                self.confirmPasswordMessageLabel.text = K.SuccessMessage.confirmPassword
                self.confirmPasswordMessageLabel.textColor = UIColor(named: K.KeyColors.greenText)
            }, invalidConfirmPassword: {
                self.confirmPasswordMessageLabel.text = K.ErrorMessage.confirmPassword
                self.confirmPasswordMessageLabel.textColor = UIColor(named: K.KeyColors.redErrorMessage)
            })
        confirmPasswordTextField.delegate = self.confirmPasswordTextFieldDelegate
    }
    
    func configureNameTextField() {
        nameTextFieldDelegate = NameTextFieldDelegate(
            validName: {
                self.nameMessageLabel.text = K.SuccessMessage.name
            }, invalidName: {
                self.nameMessageLabel.text = K.ErrorMessage.name
                self.nameMessageLabel.textColor = UIColor(named: K.KeyColors.redErrorMessage)
            })
        nameTextField.delegate = self.nameTextFieldDelegate
    }
    
    func setDefaultTextOfMessageLabels() {
        usernameMessageLabel.text = ""
        passwordTextField.text = ""
        confirmPasswordTextField.text = ""
        nameTextField.text = ""
    }
    
    @objc func updateButtonState() {
        guard let isValidUsername = usernameTextFieldDelegate?.validated, let isValidPassword = passwordTextFieldDelegate?.validated, let isValiedConfirmPassword = confirmPasswordTextFieldDelegate?.validated, let isValidName = nameTextFieldDelegate?.validated else {
            return
        }
        let isValidAllFields = isValidUsername && isValidPassword && isValiedConfirmPassword && isValidName
        nextButton.isEnabled = isValidAllFields
    }
}

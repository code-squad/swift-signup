//
//  ViewController.swift
//  SignUpApp
//
//  Created by Jun Ho JANG on 2021/03/30.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var mainTitle: UILabel!
    
    @IBOutlet weak var idStackView: StackViewUnit!
    @IBOutlet weak var passwordStackView: StackViewUnit!
    @IBOutlet weak var checkPasswordStackView: StackViewUnit!
    @IBOutlet weak var userNameStackView: StackViewUnit!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func nextButtonForModal(_ sender: Any) {
        if buttonStateCondition() == true {
            nextButton.isEnabled = true
        } else if buttonStateCondition() == false {
            nextButton.isEnabled = false
        }
    }
    
    private var signUpViewModel = SignUpViewModel()
    
    private let idTextFieldDelegate = IDTextFieldDelegate()
    private let passwordTextFieldDelegate = PasswordTextFieldDelegate()
    private let checkPasswordTextFieldDelegate = CheckPasswordTextFieldDelegate()
    private let userNameTextFieldDelegate = UserNameTextFieldDelegate()
    
    private let idValidation = IDValidation()
    private let passwordValidation = PasswordValidation()
    private let passwordEqualityValidation = PasswordEqualityValidation()
    private let userNameValidation = UserNameValidation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        setMain()
        setButton()
        setDelegation()
        applyIDStackViewValue()
        applyPasswordStackViewValue()
        applyCheckPasswordStackViewValue()
        applyUserNameStackViewValue()
        nextButton.isEnabled = false
    }
    
    private func setDelegation() {
        idTextFieldDelegate.delegatedObject = self
        passwordTextFieldDelegate.delegatedObject = self
        checkPasswordTextFieldDelegate.delegatedObject = self
        userNameTextFieldDelegate.delegatedObject = self
    }
    
    internal func buttonStateCondition() -> Bool {
        if idStackView.subLabel.textColor == .systemGreen && passwordStackView.subLabel.textColor == .systemGreen && checkPasswordStackView.subLabel.textColor == .systemGreen && userNameStackView.subLabel.textColor == .systemGreen {
            return true
        } else {
            return false
        }
    }
    
}

extension SignUpViewController: CheckDelegation {
    
    internal func checkID() {
        if let userInput = idStackView.textField.text {
            let message = idValidation.checkIDResult(input: userInput)
            let isValid = idValidation.returnValidationResult(input: userInput)
            if isValid == true {
                idStackView.subLabel.textColor = .systemGreen
            } else {
                idStackView.textField.layer.borderColor = UIColor.systemRed.cgColor
                idStackView.subLabel.textColor = .systemRed
            }
            idStackView.subLabel.text = message
        }
    }
    
    internal func checkPassword() {
        checkPasswordEquality()
        if let userInput = passwordStackView.textField.text {
            let message = passwordValidation.checkPasswordResult(input: userInput)
            let isValid = passwordValidation.returnValidationResult(input: userInput)
            if isValid == true {
                passwordStackView.subLabel.textColor = .systemGreen
            } else {
                passwordStackView.textField.layer.borderColor = UIColor.systemRed.cgColor
                passwordStackView.subLabel.textColor = .systemRed
            }
            passwordStackView.subLabel.text = message
        }
    }
    
    internal func checkPasswordEquality() {
        if let userInput = passwordStackView.textField.text, let userSecondInput = checkPasswordStackView.textField.text {
            let message = passwordEqualityValidation.checkEqualityResult(input: userInput, secondInput: userSecondInput)
            let isValid = passwordEqualityValidation.returnValidationResult(input: userInput, secondInput: userSecondInput)
            if isValid == true {
                checkPasswordStackView.subLabel.textColor = .systemGreen
            } else {
                checkPasswordStackView.textField.layer.borderColor = UIColor.systemRed.cgColor
                checkPasswordStackView.subLabel.textColor = .systemRed
            }
            checkPasswordStackView.subLabel.text = message
        }
    }
    
    internal func checkUserNameInput() {
        if let userInput = userNameStackView.textField.text {
            let message = userNameValidation.checkUserNameResult(input: userInput)
            let isValid = userNameValidation.returnValidationResult(input: userInput)
            if isValid == true {
                userNameStackView.subLabel.textColor = .systemGreen
            } else {
                userNameStackView.textField.layer.borderColor = UIColor.systemRed.cgColor
                userNameStackView.subLabel.textColor = .systemRed
            }
            userNameStackView.subLabel.text = message
        }
    }
    
}

extension SignUpViewController {
    
    private func setMain() {
        self.view.backgroundColor = UIColor(red: 245, green: 246, blue: 247, alpha: 1)
        mainTitle.textAlignment = .center
        mainTitle.text = signUpViewModel.mainTitle
        mainTitle.textColor = .systemGreen
        mainTitle.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
    }
    
    private func setButton() {
        let buttonImage = UIImage(systemName: "chevron.forward.circle.fill")
        nextButton.layer.borderColor = UIColor.black.cgColor
        nextButton.layer.borderWidth = 1
        nextButton.setImage(buttonImage, for: .normal)
        nextButton.setTitle("다음", for: .normal)
        nextButton.tintColor = UIColor.systemGreen
    }
    
    private func applyIDStackViewValue() {
        let signUpIDContent = signUpViewModel.idContent
        idStackView.title.text = signUpIDContent.title
        idStackView.textField.delegate = idTextFieldDelegate
        idStackView.textField.placeholder = signUpIDContent.placeholder
        idStackView.textField.font = UIFont.init(name: ("HelveticaNeue"), size: 14)
        idStackView.subLabel.text = signUpViewModel.emptyString
        self.view.addSubview(idStackView)
    }
    
    private func applyPasswordStackViewValue() {
        let signUpPasswordContent = signUpViewModel.passwordContent
        passwordStackView.title.text = signUpPasswordContent.title
        passwordStackView.textField.delegate = passwordTextFieldDelegate
        passwordStackView.textField.isSecureTextEntry = true
        passwordStackView.textField.placeholder = signUpPasswordContent.placeholder
        passwordStackView.textField.font = UIFont.init(name: ("HelveticaNeue"), size: 14)
        passwordStackView.subLabel.text = signUpViewModel.emptyString
        self.view.addSubview(passwordStackView)
    }
    
    private func applyCheckPasswordStackViewValue() {
        let signUpCheckPasswordContent = signUpViewModel.checkPasswordContent
        checkPasswordStackView.title.text = signUpCheckPasswordContent.title
        checkPasswordStackView.textField.delegate = checkPasswordTextFieldDelegate
        checkPasswordStackView.textField.isSecureTextEntry = true
        checkPasswordStackView.textField.placeholder = signUpCheckPasswordContent.placeholder
        checkPasswordStackView.textField.font = UIFont.init(name: ("HelveticaNeue"), size: 14)
        checkPasswordStackView.subLabel.text = signUpViewModel.emptyString
        self.view.addSubview(checkPasswordStackView)
    }
    
    private func applyUserNameStackViewValue() {
        let signUpUserNameContent = signUpViewModel.userNameContent
        userNameStackView.title.text = signUpUserNameContent.title
        userNameStackView.textField.delegate = userNameTextFieldDelegate
        userNameStackView.textField.placeholder = signUpUserNameContent.placeholder
        userNameStackView.textField.font = UIFont.init(name: ("HelveticaNeue"), size: 14)
        userNameStackView.subLabel.text = signUpViewModel.emptyString
        self.view.addSubview(userNameStackView)
    }
    
}

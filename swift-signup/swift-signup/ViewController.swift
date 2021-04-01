//
//  ViewController.swift
//  swift-signup
//
//  Created by user on 2021/03/29.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var idText: IdTextField!
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var passwordText: PasswordTextField!
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var passwordConfirmText: PasswordConfirmTextField!
    @IBOutlet weak var passwordConfirmLabel: UILabel!
    
    @IBOutlet weak var nameText: NameTextField!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    private var buttonManager = ButtonManager()
    
    //
    @IBOutlet weak var idTextField: UITextField!
    private var idTextFieldDelegate = IdTextFieldDelegate()
    
    @IBOutlet weak var passwordTextField: UITextField!
    private var passwordTextFieldDelegate = PasswordTextFieldDelegate()
    
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    private var passwordConfirmTextFieldDelegate = PasswordConfirmTextFieldDelegate()
    
    @IBOutlet weak var nameTextField: UITextField!
    private var nameTextFieldDelegate = NameTextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        NotificationCenter.default.addObserver(self, selector: #selector(idGuideText), name: IdTextFieldDelegate.idTextFieldInfo, object: idTextFieldDelegate)
        NotificationCenter.default.addObserver(self, selector: #selector(passwordGuideText), name: PasswordTextFieldDelegate.passwordTextFieldInfo, object: passwordTextFieldDelegate)
        NotificationCenter.default.addObserver(self, selector: #selector(passwordConfirmGuideText), name: PasswordConfirmTextFieldDelegate.passwordConfirmTextFieldInfo, object: passwordConfirmTextFieldDelegate)
        NotificationCenter.default.addObserver(self, selector: #selector(nameGuideText), name: NameTextFieldDelegate.nameTextFieldInfo, object: nameTextFieldDelegate)
        NotificationCenter.default.addObserver(self, selector: #selector(buttonState), name: ButtonManager.buttonState, object: buttonManager)
        
        registerDelegate()
        registerTextField()
    }

    func registerDelegate() {
        self.idTextField.delegate = idTextFieldDelegate
        self.passwordTextField.delegate = passwordTextFieldDelegate
        self.passwordConfirmTextField.delegate = passwordConfirmTextFieldDelegate
        self.nameTextField.delegate = nameTextFieldDelegate
    }
    
    func registerTextField() {
//        self.buttonManager.update(textField: type(of: idText), state: idText.currentState)
//        self.buttonManager.update(textField: type(of: passwordText), state: passwordText.currentState)
//        self.buttonManager.update(textField: type(of: passwordConfirmText), state: passwordConfirmText.currentState)
//        self.buttonManager.update(textField: type(of: nameText), state: nameText.currentState)
    }
    
    //MARK: @objc 처리
    @objc
    func idGuideText(notification: Notification) {
        guard let text = notification.userInfo?[IdValidater.MessageInfo.text] as? String,
              let color = notification.userInfo?[IdValidater.MessageInfo.color] as? UIColor
        else {
            return
        }
        self.idLabel.text = text
        self.idLabel.textColor = color
//        buttonManager.update(textField: type(of: idText), state: idText.currentState)
    }
    
    @objc
    func passwordGuideText(notification: Notification) {
        guard let text = notification.userInfo?[PasswordValidater.MessageInfo.text] as? String,
              let color = notification.userInfo?[PasswordValidater.MessageInfo.color] as? UIColor,
              let password = notification.userInfo?[PasswordValidater.MessageInfo.password] as? String
        else {
            return
        }
        self.passwordLabel.text = text
        self.passwordLabel.textColor = color
        self.passwordConfirmTextFieldDelegate.validaterUpdate(password: password)
//        buttonManager.update(textField: type(of: passwordText), state: passwordText.currentState)
    }
    
    @objc
    func passwordConfirmGuideText(notification: Notification) {
        guard let text = notification.userInfo?[PasswordConfirmValidater.MessageInfo.text] as? String,
              let color = notification.userInfo?[PasswordConfirmValidater.MessageInfo.color] as? UIColor
        else {
            return
        }
        self.passwordConfirmLabel.text = text
        self.passwordConfirmLabel.textColor = color
//        buttonManager.update(textField: type(of: passwordConfirmText), state: passwordConfirmText.currentState)
    }
    
    @objc
    func nameGuideText(notification: Notification) {
        guard let text = notification.userInfo?[NameValidater.MessageInfo.text] as? String,
              let color = notification.userInfo?[NameValidater.MessageInfo.color] as? UIColor
        else {
            return
        }
        self.nameLabel.text = text
        self.nameLabel.textColor = color
//        buttonManager.update(textField: type(of: nameText), state: nameText.currentState)
    }
    
    @objc
    func buttonState(notification: Notification) {
        guard let isActive = notification.userInfo?[ButtonManager.Info.state] as? Bool
        else {
            return
        }
        self.nextButton.isEnabled = isActive
    }
    
}


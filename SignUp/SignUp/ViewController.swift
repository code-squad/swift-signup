//
//  ViewController.swift
//  SignUp
//
//  Created by Ador on 2021/03/29.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputForId: UITextField!
    @IBOutlet weak var inputForPassword: UITextField!
    @IBOutlet weak var inputForPasswordConfirm: UITextField!
    @IBOutlet weak var inputForName: UITextField!
    
    @IBOutlet weak var messageForId: UILabel!
    @IBOutlet weak var messageForPassword: UILabel!
    @IBOutlet weak var messageForPasswordConfirm: UILabel!
    @IBOutlet weak var messageForName: UILabel!
    
    private let idFieldDelegate = IdFieldDelegate()
    private let passwordFieldDelegate = PasswordFieldDelegate()
    private let passwordConfirmFieldDelegate = PasswordConfirmFieldDelegate()
    private let nameFieldDelegate = NameFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTextFieldDelegate()
        setUpdateLabelHandler()
        setFirstResponderHandler()
        passwordConfirmFieldDelegate.passwordConfirmHandler = checkPasswordCorrespond
        
        messageForId.text = ""
        messageForPassword.text = ""
        messageForPasswordConfirm.text = ""
        messageForName.text = ""
        
        inputForId.becomeFirstResponder()
    }

    func checkPasswordCorrespond() -> Bool {
        return inputForPassword.text == inputForPasswordConfirm.text
    }
    
    func setTextFieldDelegate() {
        inputForId.delegate = idFieldDelegate
        inputForPassword.delegate = passwordFieldDelegate
        inputForPasswordConfirm.delegate = passwordConfirmFieldDelegate
        inputForName.delegate = nameFieldDelegate
    }
    
    func setUpdateLabelHandler() {
        idFieldDelegate.updateLabelHandler = { data in
            DispatchQueue.main.async {
                self.messageForId.text = data.0.rawValue
                self.messageForId.textColor = data.1
            }
        }
        
        passwordFieldDelegate.updateLabelHandler = { data in
            DispatchQueue.main.async {
                self.messageForPassword.text = data.0.rawValue
                self.messageForPassword.textColor = data.1
            }
        }
        
        passwordConfirmFieldDelegate.updateLabelHandler = { data in
            DispatchQueue.main.async {
                self.messageForPasswordConfirm.text = data.0.rawValue
                self.messageForPasswordConfirm.textColor = data.1
            }
        }
        
        nameFieldDelegate.updateLabelHandler = { data in
            DispatchQueue.main.async {
                self.messageForName.text = data.0.rawValue
                self.messageForName.textColor = data.1
            }
        }
    }
    
    func setFirstResponderHandler() {
        idFieldDelegate.firstResponserHandler = {
            self.inputForPassword.becomeFirstResponder()
        }
        
        passwordFieldDelegate.firstResponserHandler = {
            self.inputForPasswordConfirm.becomeFirstResponder()
        }
        
        passwordConfirmFieldDelegate.firstResponserHandler = {
            self.inputForName.becomeFirstResponder()
        }
    }
}

//
//  ViewController.swift
//  SignUp
//
//  Created by 양준혁 on 2021/03/29.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var IDTextField: UITextField!
    @IBOutlet var PWTextField: UITextField!
    @IBOutlet var PWRTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var IDCheckLabel: UILabel!
    @IBOutlet var passwordCheckLabel: UILabel!
    @IBOutlet var passwordReconfirmLabel: UILabel!
    @IBOutlet var nameCheckLabel: UILabel!
    @IBOutlet var nextButton: UIButton!
    
    lazy var IdTextFieldDelegate = IDTextFieldDelegate(label: IDCheckLabel)
    lazy var passwordTextFieldDelegate = PasswordTextFieldDelegate(label: passwordCheckLabel)
    lazy var passwordReconfirmTextFieldDelegate = PasswordReconfirmTextFieldDelegate(label: passwordReconfirmLabel, checker: checkPasswordReconfirm)
    lazy var nameTextFieldDelegate = NameTextFieldDelegate(label: nameCheckLabel, completion: checkName)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IDTextField.delegate = IdTextFieldDelegate
        PWTextField.delegate = passwordTextFieldDelegate
        PWRTextField.delegate = passwordReconfirmTextFieldDelegate
        nameTextField.delegate = nameTextFieldDelegate
    }

    @IBAction func nextAction(_ sender: UIButton) {
        
    }
    
    func checkPasswordReconfirm() -> Bool {
        return PWTextField.text == PWRTextField.text
    }
    
    func checkName() -> Bool? {
        return nameTextField.text?.isEmpty
    }
    
}


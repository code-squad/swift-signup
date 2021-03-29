//
//  ViewController.swift
//  SignUp
//
//  Created by 오킹 on 2021/03/29.
//

import UIKit

class FirstSignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var textFields: [UITextField]!
    let textFieldDelegate = TextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFields()
    }

    private func configureTextFields() {
        textFields.forEach { textField in
            textField.layer.borderColor = CGColor(red: 112, green: 112, blue: 112, alpha: 1)
            textField.layer.borderWidth = 1.0
            textField.delegate = textFieldDelegate
        }
    }
}

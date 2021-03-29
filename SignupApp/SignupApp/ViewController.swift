//
//  ViewController.swift
//  SignupApp
//
//  Created by Issac on 2021/03/29.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var IDField: CustomTextField!
    @IBOutlet weak var passwordField: CustomTextField!
    @IBOutlet weak var checkPasswordField: CustomTextField!
    @IBOutlet weak var nameField: CustomTextField!
    
    @IBOutlet weak var IDMessageLabel: UILabel!
    @IBOutlet weak var passwordMessageLabel: UILabel!
    @IBOutlet weak var checkPasswordMessageLabel: UILabel!
    @IBOutlet weak var nameMessageLabel: UILabel!
    
    
    @IBOutlet var textFields: [CustomTextField]!
    @IBOutlet var messageLabel: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFields.forEach { (textField) in
            textField.delegate = self
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

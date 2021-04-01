//
//  ViewController.swift
//  SignUp
//
//  Created by 오킹 on 2021/03/29.
//

import UIKit

class FirstSignUpViewController: UIViewController {
    
    @IBOutlet weak var idTextField: SignUpTextField!
    @IBOutlet weak var pwTextField: SignUpTextField!
    @IBOutlet weak var recheckingPwTextField: SignUpTextField!
    @IBOutlet weak var nameTextField: SignUpTextField!
    
    @IBOutlet weak var idResultLabel: UILabel!
    @IBOutlet weak var pwResultLabel: UILabel!
    @IBOutlet weak var recheckPwResultLabel: UILabel!
    @IBOutlet weak var nameResultLabel: UILabel!
    
    let idTextFieldDelegate = IdTextFieldDelegate()
    let pwTextFieldDelegate = PwTextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idTextField.delegate = idTextFieldDelegate
        pwTextField.delegate = pwTextFieldDelegate
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateIdResultLabel), name: IdTextFieldDelegate.notificationName, object: idTextFieldDelegate)
        NotificationCenter.default.addObserver(self, selector: #selector(updatePwResultLabel), name: PwTextFieldDelegate.notificationName, object: pwTextFieldDelegate)
    }
    
    @objc
    private func updateIdResultLabel(notification: Notification) {
        ///result = [텍스트필드 올바르게 작성했는지  : 그에 해당하는 메세지 ]
        guard let userInfo = notification.userInfo,
              let result = userInfo as? [Bool : String] else {
            return
        }

        updateLabel(idResultLabel, condition: result)
    }
    
    @objc
    private func updatePwResultLabel(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let result = userInfo as? [Bool : String] else {
            return
        }

        updateLabel(pwResultLabel, condition: result)
    }
    
    @IBAction func editingChangedRecheckingPwTextField(_ sender: SignUpTextField) {

        let result = Validator.isSameText(first: pwTextField.text!, second: recheckingPwTextField.text!)
        
            updateLabel(recheckPwResultLabel, condition: result)
    }
    
    @IBAction func didTabNextButton(_ sender: SignUpButton) {
        ValidateAllTextField().forEach { label, result in
            result.keys.forEach { isCorrect in
                if isCorrect == false { updateLabel(label, condition: result) }
            }
        }
    }
    
    private func updateLabel(_ label: UILabel, condition: [Bool:String]) {
        
        if let message = condition[true] {
            label.text = message
            label.textColor = .systemGreen
        }
        else {
            label.text = condition[false]
            label.textColor = .systemRed
        }
    }
    
    private func ValidateAllTextField() -> [UILabel : [Bool:String]] {
        let results = [idResultLabel! : Validator.isCorrected(id: idTextField.text!),
                             pwResultLabel! : Validator.isCorrected(pw: pwTextField.text!),
                             recheckPwResultLabel! : Validator.isSameText(first: pwTextField.text!, second: recheckingPwTextField.text!),
                             nameResultLabel! : Validator.isEmpty(nameTextField.text!)]
        return results
    }
}

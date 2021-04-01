//
//  ViewController.swift
//  SignUp
//
//  Created by 오킹 on 2021/03/29.
//

import UIKit

class FirstSignUpViewController: UIViewController {
    
    @IBOutlet weak var idTextField: SignUpTextField!
    @IBOutlet weak var pwTextFiled: SignUpTextField!
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
        pwTextFiled.delegate = pwTextFieldDelegate
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateIdResultLabel), name: IdTextFieldDelegate.notificationName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updatePwResultLabel), name: PwTextFieldDelegate.notificationName, object: nil)
    }
    
    @objc
    private func updateIdResultLabel(notification: Notification) {
        guard let tempUserInfo = notification.userInfo,
              let userInfo = tempUserInfo as? [Bool : String] else {
            return
        }

        updateLabel(idResultLabel, condition: userInfo)
    }
    
    @objc
    private func updatePwResultLabel(notification: Notification) {
        guard let tempUserInfo = notification.userInfo,
              let userInfo = tempUserInfo as? [Bool : String] else {
            return
        }

        updateLabel(pwResultLabel, condition: userInfo)
    }
    
    @IBAction func editingChangedRecheckingPwTextField(_ sender: Any) {

        let result = Validator.isSameText(first: pwTextFiled.text!, second: recheckingPwTextField.text!)
        
            updateLabel(recheckPwResultLabel, condition: result)
    }
    
    @IBAction func didTabNextButton(_ sender: SignUpButton) {
        canGoNextPage().forEach { label, result in
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
    
    private func canGoNextPage() -> [UILabel : [Bool:String]] {
        let canGoNextPage = [idResultLabel! : Validator.isCorrected(id: idTextField.text!),
                             pwResultLabel! : Validator.isCorrected(pw: pwTextFiled.text!),
                             recheckPwResultLabel! : Validator.isSameText(first: pwResultLabel.text!, second: recheckPwResultLabel.text!),
                             nameResultLabel! : Validator.isEmpty(nameTextField.text!)]
        return canGoNextPage
    }
}

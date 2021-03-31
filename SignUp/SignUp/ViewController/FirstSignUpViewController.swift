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
    @IBOutlet weak var idResultLabel: UILabel!
    @IBOutlet weak var pwResultLabel: UILabel!
    
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
    
    private func updateLabel(_ label: UILabel, condition: [Bool:String]) {
        label.isHidden = false
        
        if let message = condition[true] {
            label.text = message
            label.textColor = .systemGreen
        }
        else {
            label.text = condition[false]
            label.textColor = .systemRed
        }
    }
}

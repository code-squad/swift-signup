//
//  ViewController.swift
//  SignUp
//
//  Created by 오킹 on 2021/03/29.
//

import UIKit

class FirstSignUpViewController: UIViewController {

    @IBOutlet weak var idTextField: SignUpTextField!
    @IBOutlet weak var idResultLabel: UILabel!
    
    let idTextFieldDelegate = IdTextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idTextField.delegate = idTextFieldDelegate
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateIdResultLabel), name: IdTextFieldDelegate.notificationName, object: nil)
    }

    @objc private func updateIdResultLabel(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let isCorrectId = userInfo["correctId"] as? Bool else {
            return
        }

        idResultLabel.isHidden = false
        if !isCorrectId {
            idResultLabel.text = "5~20자의 영문 소문자, 숫자와 특수기호(_)(-) 만 사용 가능합니다."
            idResultLabel.textColor = .systemRed
        }
        else {
            idResultLabel.text = "사용 가능한 아이디입니다."
            idResultLabel.textColor = .systemGreen
        }
    }
}

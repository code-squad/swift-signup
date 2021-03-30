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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.idText.delegate = idText
        self.passwordText.delegate = passwordText
        
        NotificationCenter.default.addObserver(self, selector: #selector(idGuideText), name: CustomTextField.idState, object: idText)
        NotificationCenter.default.addObserver(self, selector: #selector(passwordGuideText), name: CustomTextField.passwordState, object: passwordText)
    }

    @objc
    func idGuideText(notification: Notification) {
        guard let text = notification.userInfo?[CustomTextField.UserInfo.textInfo] as? String, let color = notification.userInfo?[CustomTextField.UserInfo.colorInfo] as? UIColor else {
            return
        }
        self.idLabel.text = text
        self.idLabel.textColor = color
    }
    
    @objc
    func passwordGuideText(notification: Notification) {
        guard let text = notification.userInfo?[CustomTextField.UserInfo.textInfo] as? String, let color = notification.userInfo?[CustomTextField.UserInfo.colorInfo] as? UIColor else {
            return
        }
        self.passwordLabel.text = text
        self.passwordLabel.textColor = color
    }
}


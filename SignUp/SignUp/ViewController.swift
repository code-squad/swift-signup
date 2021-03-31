//
//  ViewController.swift
//  SignUp
//
//  Created by 심영민 on 2021/03/29.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var recheckPassword: UITextField!
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var idCheckLabel: UILabel!
    @IBOutlet weak var passwordCheckLabel: UILabel!
    @IBOutlet weak var passwordReCheckLabel: UILabel!
    @IBOutlet weak var userNameCheckLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    private var idDelegate = IDTextFieldDelegate()
    private var pwDelegate = PWTextFieldDelegate()
    private var recheckPwDelegate = RecheckPWTextFieldDelegate()
    private var nameDelegate = NamePWTextFieldDelegate()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setDelegate()
        setObserver()
    }
    
    func setDelegate() {
        id.delegate = idDelegate
        password.delegate = pwDelegate
        recheckPassword.delegate = recheckPwDelegate
        userName.delegate = nameDelegate
    }
    
    func setObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(changePWLabel),
                                               name: NSNotification.Name(rawValue: "pw"),
                                               object: nil)
    }
    
    @objc func changePWLabel(_ notificaion: Notification) {
        if let message = notificaion.userInfo as? [Validate.Message : String] {
            for (key, text) in message {
                if key == Validate.Message.Success {
                    passwordCheckLabel.textColor = .green
                } else {
                    passwordCheckLabel.textColor = .red
                }
                passwordCheckLabel.text = text
            }
        }
    }
}

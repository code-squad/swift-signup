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
    @IBOutlet var IDCheckLabel: UILabel!
    @IBOutlet var PWCheckLabel: UILabel!
    @IBOutlet var PWReconfirmLabel: UILabel!
    @IBOutlet var nameCheckLabel: UILabel!
    
    var IdTextFieldDelegate = IDTextFieldDelegate()
    var pwTextFieldDelegate = PWTextFieldDelegate()
    var pwrTextFieldDelegate = PWRTextFieldDelegate()
    var labelManager = LabelManager()
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IDTextField.delegate = IdTextFieldDelegate
        PWTextField.delegate = pwTextFieldDelegate
        PWRTextField.delegate = pwrTextFieldDelegate
        NotificationCenter.default.addObserver(self, selector: #selector(showIDLabel), name: NSNotification.Name.init(rawValue: "identifier"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showPWLabel), name: NSNotification.Name.init(rawValue: "password"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showPWRLabel), name: NSNotification.Name.init(rawValue: "passwordReconfirm"), object: nil)
    }

    @objc func showIDLabel(notification: Notification) {
        let getValue = notification.object as! IDTextFieldState
        labelManager.checkCorrectID(label: IDCheckLabel, state: getValue)
    }

    @objc func showPWLabel(notification: Notification) {
        let getValue = notification.object as! PasswordTextFieldState
        labelManager.checkPassword(label: PWCheckLabel, state: getValue)
    }
    
    @objc func showPWRLabel() {
        labelManager.checkPasswordConfirm(pw: PWTextField, pwr: PWRTextField, pwrLabel: PWReconfirmLabel)
    }
}


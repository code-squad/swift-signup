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
    @IBOutlet var PWCheckLabel: UILabel!
    @IBOutlet var PWReconfirmLabel: UILabel!
    @IBOutlet var nameCheckLabel: UILabel!
    @IBOutlet var nextButton: UIButton!
    
    lazy var IdTextFieldDelegate = IDTextFieldDelegate(label: IDCheckLabel)
    var pwTextFieldDelegate = PWTextFieldDelegate()
    var pwrTextFieldDelegate = PWRTextFieldDelegate()
    var nameTextFieldDelegate = NameTextFieldDelegate()
    var labelManager = LabelManager()
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IDTextField.delegate = IdTextFieldDelegate
        PWTextField.delegate = pwTextFieldDelegate
        PWRTextField.delegate = pwrTextFieldDelegate
        nameTextField.delegate = nameTextFieldDelegate
        NotificationCenter.default.addObserver(self, selector: #selector(showPWLabel), name: NSNotification.Name.init(rawValue: "password"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showPWRLabel), name: NSNotification.Name.init(rawValue: "passwordReconfirm"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showNameLabel), name: NSNotification.Name.init(rawValue: "name"), object: nil)

    }

    @objc func showPWLabel(notification: Notification) {
        let getValue = notification.object as! PasswordState
        labelManager.checkPassword(label: PWCheckLabel, state: getValue)
    }
    
    @objc func showPWRLabel() {
        labelManager.checkPasswordConfirm(pw: PWTextField, pwr: PWRTextField, pwrLabel: PWReconfirmLabel)
    }
    
    @objc func showNameLabel() {
        labelManager.checkName(name: nameTextField, label: nameCheckLabel)
    }
    @IBAction func nextAction(_ sender: UIButton) {
        
    }
    
}


//
//  ViewController.swift
//  SignUp
//
//  Created by 양준혁 on 2021/03/29.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var IDTextField: UITextField!
    @IBOutlet var pwTextField: UITextField!
    @IBOutlet var IDCheckLabel: UILabel!
    @IBOutlet var PWCheckLabel: UILabel!
    @IBOutlet var PWReconfirmLabel: UILabel!
    @IBOutlet var nameCheckLabel: UILabel!
    
    var IdTextFieldDelegate = IDTextFieldDelegate()
    var pwTextFieldDelegate = PWTextFieldDelegate()
    var labelManager = LabelManager()
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IDTextField.delegate = IdTextFieldDelegate
        pwTextField.delegate = pwTextFieldDelegate
        NotificationCenter.default.addObserver(self, selector: #selector(showIDLabel), name: NSNotification.Name.init(rawValue: "identifier"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showPWLabel), name: NSNotification.Name.init(rawValue: "password"), object: nil)
    }

    @objc func showIDLabel(notification: Notification) {
        let getValue = notification.object as! IDTextFieldState
        labelManager.checkCorrectID(label: IDCheckLabel, state: getValue)
    }

    @objc func showPWLabel(notification: Notification) {
        let getValue = notification.object as! PasswordTextFieldState
        labelManager.checkPassword(label: PWCheckLabel, state: getValue)
    }
}


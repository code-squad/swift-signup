//
//  ViewController.swift
//  swift-signup
//
//  Created by user on 2021/03/29.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var idText: idTextField!
    
    @IBOutlet weak var idLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.idText.delegate = idText
        NotificationCenter.default.addObserver(self, selector: #selector(idGuideText(notification:)), name: idTextField.idState, object: idText)
    }

    @objc
    func idGuideText(notification: Notification) {
        guard let text = notification.userInfo?[idTextField.UserInfo.textInfo] as? String, let color = notification.userInfo?[idTextField.UserInfo.colorInfo] as? UIColor else {
            return
        }
        self.idLabel.text = text
        self.idLabel.textColor = color
    }
}


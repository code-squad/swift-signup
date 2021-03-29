//
//  ViewController.swift
//  SignUp
//
//  Created by 양준혁 on 2021/03/29.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var IDTextField: UITextField!
    @IBOutlet var IDCheckLabel: UILabel!
    @IBOutlet var PWCheckLabel: UILabel!
    @IBOutlet var PWReconfirmLabel: UILabel!
    @IBOutlet var nameCheckLabel: UILabel!
    
    var IdTextFieldDelegate = IDTextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IDTextField.delegate = IdTextFieldDelegate
        NotificationCenter.default.addObserver(self, selector: #selector(showCorrectID), name: NSNotification.Name.init(rawValue: "Correct"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showIncorrectID), name: NSNotification.Name.init(rawValue: "Incorrect"), object: nil)
    }

    @objc func showCorrectID() {
        IDCheckLabel.text = "사용 가능합니다."
        IDCheckLabel.textColor = #colorLiteral(red: 0.1540483236, green: 0.6966413856, blue: 0.1375852525, alpha: 1)
    }
    
    @objc func showIncorrectID() {
        IDCheckLabel.text = "5~20자의 영문 소문자, 숫자와 특수기호(_)(-) 만 사용 가능합니다."
        IDCheckLabel.textColor = #colorLiteral(red: 0.9967475533, green: 0.03828956559, blue: 0.05758263916, alpha: 1)
    }
}


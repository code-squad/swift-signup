//
//  ViewController.swift
//  SignUpApp
//
//  Created by sonjuhyeong on 2021/03/29.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordCheckTextField: UITextField!
    @IBOutlet weak var nameTextFiled: UITextField!
    @IBOutlet weak var idCheckLabel: UILabel!
    @IBOutlet weak var pwCheckLabel: UILabel!
    @IBOutlet weak var pwReCheckLabel: UILabel!
    @IBOutlet weak var nameCheckLabel: UILabel!
    
    
    private let regex = RegularExpression()
    private let idTextFieldDelegate = IdTextFieldDelegate()
    private let pwTextFiledDelegate = PwTextFieldDelegate()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        idTextField.delegate = idTextFieldDelegate
        passwordTextField.delegate = pwTextFiledDelegate
        idTextField.addTarget(self, action: #selector(checkIdLabel), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(checkPasswordLabel), for: .editingChanged)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func checkIdLabel() {
        guard let text = idTextField.text else { return }
        switch regex.isValidId(id: text) {
        case true:
            idCheckLabel.text = "사용 가능한 아이디입니다."
            idCheckLabel.textColor = .systemGreen
        case false:
            idCheckLabel.text = "5~20자의 영문 소문자, 숫자와 특수기호(_)(-) 만 사용 가능합니다."
            idCheckLabel.textColor = .systemRed
            idCheckLabel.sizeToFit()
        }
    }
    
    @objc func checkPasswordLabel() {
        guard let text = passwordTextField.text else { return }
        switch regex.isValidPassword(pw: text) {
        case true:
            pwCheckLabel.text = "사용 가능한 비밀번호입니다."
            pwCheckLabel.textColor = .systemGreen
        case false:
            pwCheckLabel.text = "똑바로 써"
            pwCheckLabel.textColor = .systemRed
        }
    }
}

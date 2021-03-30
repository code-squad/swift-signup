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
    private let regex = RegularExpression()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
    }
}

//MARK: - UITextFiledDelegate
extension ViewController: UITextFieldDelegate {
    func setDelegate() {
        idTextField.delegate = self
        passwordTextField.delegate = self
        passwordCheckTextField.delegate = self
        nameTextFiled.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.systemBlue.cgColor
        textField.layer.borderWidth = 1.0
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.layer.borderColor ==  UIColor.systemBlue.cgColor {
            textField.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    // 화면 터치시 키보드 다운
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    // 리턴키 델리게이트 처리
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

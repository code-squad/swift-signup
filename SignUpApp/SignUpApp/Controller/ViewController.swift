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
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func checkId() {
        guard let text = idTextField.text else { return }
        switch regex.isValidId(id: text) {
        case true:
            print("성공")
        default:
            print("실패")
        }
    }
    
    func checkPassword() {
        guard let text = passwordTextField.text else { return }
        switch regex.isValidPassword(pw: text) {
        case true:
            print("성공")
        default:
            print("실패")
        }
    }
}


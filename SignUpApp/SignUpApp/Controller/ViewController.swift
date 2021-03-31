//
//  ViewController.swift
//  SignUpApp
//
//  Created by sonjuhyeong on 2021/03/29.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet weak var idTextField: BasicTextField!
    @IBOutlet weak var passwordTextField: BasicTextField!
    @IBOutlet weak var passwordCheckTextField: BasicTextField!
    @IBOutlet weak var nameTextField: BasicTextField!
    @IBOutlet weak var idCheckLabel: BasicStateLabel!
    @IBOutlet weak var pwCheckLabel: BasicStateLabel!
    @IBOutlet weak var pwReCheckLabel: BasicStateLabel!
    @IBOutlet weak var nameCheckLabel: BasicStateLabel!
    @IBOutlet weak var nextButton: BasicButton!
    
    private let regex = RegularExpression()
    private let idTextFieldDelegate = IdTextFieldDelegate()
    private let pwTextFieldDelegate = PwTextFieldDelegate()
    private let pwCheckFieldDelegate = PwCheckTextFieldDelegate()
    private let nameTextFieldDelegate = NameTextFieldDelegate()
    private var trueCount: Int = 0
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        idTextField.delegate = idTextFieldDelegate
        passwordTextField.delegate = pwTextFieldDelegate
        passwordCheckTextField.delegate = pwCheckFieldDelegate
        nameTextField.delegate = nameTextFieldDelegate
        setAddTarger()
        pwCheckFieldDelegate.checkBool = compareText()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func setAddTarger() {
        idTextField.addTarget(self, action: #selector(checkIdLabel), for: .editingDidEnd)
        passwordTextField.addTarget(self, action: #selector(checkPasswordLabel), for: .editingDidEnd)
        passwordCheckTextField.addTarget(self, action: #selector(checkPasswordCheckLabel), for: .editingDidEnd)
        nameTextField.addTarget(self, action: #selector(checkNameLabel), for: .editingDidEnd)
        nameTextField.addTarget(self, action: #selector(checkNextButton), for: .editingDidEnd)
    }
    
    func compareText() -> Bool {
        return passwordTextField.text == passwordCheckTextField.text
    }
    
    //MARK: - Label state method
    @objc func checkIdLabel() {
        guard let text = idTextField.text else { return }
        switch regex.isValidId(id: text) {
        case true:
            idCheckLabel.text = CheckLabelState.IdState.Pass.rawValue
            idCheckLabel.textColor = .systemGreen
            trueCount += 1
            print(trueCount)
        case false:
            idCheckLabel.text = CheckLabelState.IdState.Invalid.rawValue
            idCheckLabel.textColor = .systemRed
            idCheckLabel.sizeToFit()
        }
    }
    
    @objc func checkPasswordLabel() {
        guard let text = passwordTextField.text else { return }
        switch regex.isValidPassword(pw: text) {
        case 1:
            pwCheckLabel.text = CheckLabelState.PwState.Invalid.rawValue
            pwCheckLabel.textColor = .systemRed
        case 2:
            pwCheckLabel.text = CheckLabelState.PwState.MinimumEnglish.rawValue
            pwCheckLabel.textColor = .systemRed
        case 3:
            pwCheckLabel.text = CheckLabelState.PwState.InvalidNumber.rawValue
            pwCheckLabel.textColor = .systemRed
        case 4:
            pwCheckLabel.text = CheckLabelState.PwState.InvalidSpecialCharacter.rawValue
            pwCheckLabel.textColor = .systemRed
        default:
            pwCheckLabel.text = CheckLabelState.PwState.Pass.rawValue
            pwCheckLabel.textColor = .systemGreen
            trueCount += 1
            print(trueCount)
        }

    }
    
    @objc func checkPasswordCheckLabel() {
        guard let text = passwordCheckTextField.text else { return }
        if passwordTextField.text == text {
            pwReCheckLabel.text = CheckLabelState.PwCheckState.Pass.rawValue
            pwReCheckLabel.textColor = .systemGreen
            trueCount += 1
            print(trueCount)
        }else{
            pwReCheckLabel.text = CheckLabelState.PwCheckState.Invalid.rawValue
            pwReCheckLabel.textColor = .systemRed
        }
    }
    
    @objc func checkNameLabel() {
        guard let text = nameTextField.text else { return }
        if text.isEmpty {
            nameCheckLabel.text = CheckLabelState.NameState.None.rawValue
            nameCheckLabel.textColor = .systemRed
        }else{
            nameCheckLabel.text = CheckLabelState.NameState.Pass.rawValue
            nameCheckLabel.textColor = .systemGreen
            trueCount += 1
            print(trueCount)
        }
    }
    
    @objc func checkNextButton() {
        if trueCount >= 4 {
            nextButton.isEnabled = true
            nextButton.setTitleColor(.systemGreen, for: .normal)
        }
    }
}

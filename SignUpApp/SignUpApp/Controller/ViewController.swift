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
    private let textFieldDelegate = TextFieldDelegate()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setAddTargerForlabel()
        setAddTargerForButton()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //MARK: - Setting Delegate, Setting Addtarget
    func setDelegate() {
        idTextField.delegate = textFieldDelegate
        passwordTextField.delegate = textFieldDelegate
        passwordCheckTextField.delegate = textFieldDelegate
        nameTextField.delegate = textFieldDelegate
    }
    
    func setAddTargerForlabel() {
        idTextField.addTarget(self, action: #selector(checkIdLabel), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(checkPasswordLabel), for: .editingChanged)
        passwordCheckTextField.addTarget(self, action: #selector(checkPasswordCheckLabel), for: .editingChanged)
        nameTextField.addTarget(self, action: #selector(checkNameLabel), for: .editingChanged)
    }
    
    func setAddTargerForButton() {
        idTextField.addTarget(self, action: #selector(checkNextButton), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(checkNextButton), for: .editingChanged)
        passwordCheckTextField.addTarget(self, action: #selector(checkNextButton), for: .editingChanged)
        nameTextField.addTarget(self, action: #selector(checkNextButton), for: .editingChanged)
    }
    
    //MARK: - UI Change method
    @objc func checkIdLabel() {
        guard let text = idTextField.text else { return }
        var duplicateCheckBool: Bool = false
        NetworkManager.getData(completionHandler: { (users) in
            if users.contains(text) {
                duplicateCheckBool = true
            }else {
                duplicateCheckBool = false
            }
            DispatchQueue.main.async {
                if duplicateCheckBool == false  && self.regex.isValidId(id: text) == true {
                    self.idCheckLabel.text = CheckLabelState.IdState.Pass.rawValue
                    self.idTextField.layer.borderColor = UIColor.systemGreen.cgColor
                    self.idCheckLabel.textColor = .systemGreen
                }else if duplicateCheckBool == true {
                    self.idCheckLabel.text = CheckLabelState.IdState.Duplicate.rawValue
                    self.idCheckLabel.textColor = .systemRed
                    self.idTextField.layer.borderColor = UIColor.systemRed.cgColor
                }else{
                    self.idCheckLabel.text = CheckLabelState.IdState.Invalid.rawValue
                    self.idCheckLabel.textColor = .systemRed
                    self.idTextField.layer.borderColor = UIColor.systemRed.cgColor
                    self.idCheckLabel.sizeToFit()
                }
            }
        })
    }
    
    @objc func checkPasswordLabel() {
        guard let text = passwordTextField.text else { return }
        switch regex.isValidPassword(pw: text) {
        case 1:
            pwCheckLabel.text = CheckLabelState.PwState.Invalid.rawValue
            pwCheckLabel.textColor = .systemRed
            passwordTextField.layer.borderColor = UIColor.systemRed.cgColor
        case 2:
            pwCheckLabel.text = CheckLabelState.PwState.MinimumEnglish.rawValue
            pwCheckLabel.textColor = .systemRed
            passwordTextField.layer.borderColor = UIColor.systemRed.cgColor
        case 3:
            pwCheckLabel.text = CheckLabelState.PwState.InvalidNumber.rawValue
            pwCheckLabel.textColor = .systemRed
            passwordTextField.layer.borderColor = UIColor.systemRed.cgColor
        case 4:
            pwCheckLabel.text = CheckLabelState.PwState.InvalidSpecialCharacter.rawValue
            pwCheckLabel.textColor = .systemRed
            passwordTextField.layer.borderColor = UIColor.systemRed.cgColor
        default:
            pwCheckLabel.text = CheckLabelState.PwState.Pass.rawValue
            pwCheckLabel.textColor = .systemGreen
            passwordTextField.layer.borderColor = UIColor.systemGreen.cgColor
        }

    }
    
    @objc func checkPasswordCheckLabel() {
        guard let text = passwordCheckTextField.text else { return }
        if passwordTextField.text == text && !text.isEmpty {
            pwReCheckLabel.text = CheckLabelState.PwCheckState.Pass.rawValue
            pwReCheckLabel.textColor = .systemGreen
            passwordCheckTextField.layer.borderColor = UIColor.systemGreen.cgColor
        }else{
            pwReCheckLabel.text = CheckLabelState.PwCheckState.Invalid.rawValue
            pwReCheckLabel.textColor = .systemRed
            passwordCheckTextField.layer.borderColor = UIColor.systemRed.cgColor
        }
    }
    
    @objc func checkNameLabel() {
        guard let text = nameTextField.text else { return }
        if text.isEmpty {
            nameCheckLabel.text = CheckLabelState.NameState.None.rawValue
            nameCheckLabel.textColor = .systemRed
            nameTextField.layer.borderColor = UIColor.systemRed.cgColor
        }else{
            nameCheckLabel.text = CheckLabelState.NameState.Pass.rawValue
            nameCheckLabel.textColor = .systemGreen
            nameTextField.layer.borderColor = UIColor.systemGreen.cgColor
        }
    }
    
    @objc func checkNextButton() {
        let idPass: Bool = {
            return idCheckLabel.text == CheckLabelState.IdState.Pass.rawValue
        }()
        let pwPass: Bool = {
            return pwCheckLabel.text == CheckLabelState.PwState.Pass.rawValue
        }()
        let pwCheckPass: Bool = {
            return pwReCheckLabel.text == CheckLabelState.PwCheckState.Pass.rawValue
        }()
        let namePass: Bool = {
            return nameCheckLabel.text == CheckLabelState.NameState.Pass.rawValue
        }()
        if idPass && pwPass && pwCheckPass && namePass {
            nextButton.isEnabled = true
            nextButton.setTitleColor(.systemGreen, for: .normal)
        }else {
            nextButton.isEnabled = false
            nextButton.setTitleColor(.gray, for: .normal)
        }
    }
}

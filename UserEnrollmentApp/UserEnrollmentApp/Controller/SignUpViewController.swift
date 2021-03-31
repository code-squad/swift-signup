//
//  ViewController.swift
//  UserEnrollmentApp
//
//  Created by 조중윤 on 2021/03/29.
//

import UIKit

class SignUpViewController: UIViewController {
    let idTextFieldDelegate = SignUpSceneIdTextFieldDelegate()
    let passwordTextFieldDelegate = SignUpScenePasswordTextFieldDelegate()
    let passwordReconfirmTextFieldDelegate = SignUpScenePasswordReconfirmTextFieldDelegate()
    let nameTextFieldDelegate = SignUpSceneNameTextFieldDelegate()
    
    @IBOutlet weak var nextButton: DesignableButton!
    
    @IBOutlet weak var idTextField: DesignableTextField!
    @IBOutlet weak var passwordTextField: DesignableTextField!
    @IBOutlet weak var passwordReconfirmTextField: DesignableTextField!
    @IBOutlet weak var nameTextField: DesignableTextField!
    
    @IBOutlet weak var idValidationResultLabel: ResultExplanationLabel!
    @IBOutlet weak var passwordValidationResultLabel: ResultExplanationLabel!
    @IBOutlet weak var passwordReconfirmValidationResultLabel: ResultExplanationLabel!
    @IBOutlet weak var nameValidationResultLabel: ResultExplanationLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nextButton.isEnabled = false
        
        self.idTextField.delegate = idTextFieldDelegate
        self.passwordTextField.delegate = passwordTextFieldDelegate
        self.passwordReconfirmTextField.delegate = passwordReconfirmTextFieldDelegate
        self.nameTextField.delegate = nameTextFieldDelegate
        
        self.idTextFieldDelegate.resultNotifyingDelegate = self
        self.passwordTextFieldDelegate.resultNotifyingDelegate = self
        self.passwordReconfirmTextFieldDelegate.resultNotifyingDelegate = self
        self.nameTextFieldDelegate.resultNotifyingDelegate = self
    }
    
    @IBAction func NextButtonPressed(_ sender: DesignableButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "PrivateInfoViewController") as! PrivateInfoViewController
        newViewController.modalPresentationStyle = .fullScreen
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        self.present(newViewController, animated: false, completion: nil)
    }
    
    func enableNextButtonIfAllValid() {
        self.nextButton.isEnabled = idTextField.isValid && passwordTextField.isValid && passwordReconfirmTextField.isValid && nameTextField.isValid
    }
}

extension SignUpViewController: ResultNotifyingDelegate {
    func passTextFieldValue(sender: UITextFieldDelegate, value: String) {
        switch sender {
        case is SignUpScenePasswordReconfirmTextFieldDelegate:
            let result = value == passwordTextField.text
            passwordReconfirmValidationResultLabel.setTextColor(isGoodExplanation: result)
            passwordReconfirmTextField.setBorderColor(withValidInput: result)
            passwordReconfirmTextField.isValid = result
            if result == true {
                passwordReconfirmValidationResultLabel.text = "비밀번호가 일치합니다."
            } else {
                passwordReconfirmValidationResultLabel.text = "비밀번호가 일치하지 않습니다."
            }
        default: return
        }
        enableNextButtonIfAllValid()
    }
    
    func passValidationResult(sender: UITextFieldDelegate, result: Bool, explanation: String) {
        switch sender {
        case is SignUpSceneIdTextFieldDelegate:
            idValidationResultLabel.text = explanation
            idValidationResultLabel.setTextColor(isGoodExplanation: result)
            idTextField.isValid = result
            idTextField.setBorderColor(withValidInput: result)
            
        case is SignUpScenePasswordTextFieldDelegate:
            passwordValidationResultLabel.text = explanation
            passwordValidationResultLabel.setTextColor(isGoodExplanation: result)
            passwordTextField.isValid = result
            passwordTextField.setBorderColor(withValidInput: result)
            
        case is SignUpSceneNameTextFieldDelegate:
            nameValidationResultLabel.text = explanation
            nameValidationResultLabel.setTextColor(isGoodExplanation: result)
            nameTextField.isValid = result
            nameTextField.setBorderColor(withValidInput: result)
        default: return
        }
        enableNextButtonIfAllValid()
    }
}

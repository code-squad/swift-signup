//
//  SignUpViewController.swift
//  SignUp
//
//  Created by 박혜원 on 2021/03/29.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet var signUpTextFields : SignUpViewModel!
    @IBOutlet var signUpLabels: SignUpLabelViewModel!
    
    var activateTextField : UITextField? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpTextFields.id.bind(control: { [weak self] (state) in
            self?.signUpLabels.id.text = state.state.rawValue
        })
        signUpTextFields.password.bind(control: { [weak self] (state) in
            self?.signUpLabels.password.text = state.state.rawValue
        })
        configureDelegate()
    }
    @IBAction func didTouchNextButton(_ sender: Any) {
        
        guard let personInfoVC = self.storyboard?.instantiateViewController(identifier: "personInform") as? PersonInformViewController else {
            return
        }
        personInfoVC.modalTransitionStyle = .coverVertical
        personInfoVC.modalPresentationStyle = .fullScreen
        present(personInfoVC, animated: true, completion: nil)
    }
    func configureDelegate(){
        
    }
}

extension SignUpViewController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activateTextField = textField
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == signUpTextFields.id {
            self.signUpTextFields.password.becomeFirstResponder()
        } else if textField == signUpTextFields.password {
            self.signUpTextFields.repassword.becomeFirstResponder()
        } else if textField == signUpTextFields.repassword {
            self.signUpTextFields.name.becomeFirstResponder()
        }else {
            activateTextField = nil
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

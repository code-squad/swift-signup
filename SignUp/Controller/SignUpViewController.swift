//
//  SignUpViewController.swift
//  SignUp
//
//  Created by 박혜원 on 2021/03/29.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet var signUpViewModel : SignUpViewModel!
    
    var activateTextField : UITextField? = nil
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var repasswordLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpViewModel.id.bind(control: { [weak self] (state) in
            self?.idLabel.text = state.state.rawValue
        })
        signUpViewModel.password.bind(control: { [weak self] (state) in
            self?.passwordLabel.text = state.state.rawValue
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
        if textField == signUpViewModel.id {
            self.signUpViewModel.password.becomeFirstResponder()
        } else if textField == signUpViewModel.password {
            self.signUpViewModel.repassword.becomeFirstResponder()
        } else if textField == signUpViewModel.repassword {
            self.signUpViewModel.name.becomeFirstResponder()
        }else {
            activateTextField = nil
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

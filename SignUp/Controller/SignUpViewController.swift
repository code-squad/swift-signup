//
//  SignUpViewController.swift
//  SignUp
//
//  Created by 박혜원 on 2021/03/29.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet var idViewModel: IDViewModel!
    @IBOutlet var passwordViewModel: PasswordViewModel!
    @IBOutlet var nameViewModel: NameViewModel!
    
    var activateTextField : UITextField? = nil
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var repasswordLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idViewModel.bind(control: { [weak self] (state) in
            self?.idLabel.text = state.state.rawValue
        })
        passwordViewModel.bind(control: { [weak self] (state) in
            self?.passwordLabel.text = state.state.rawValue
        })
        nameViewModel.bind(control: { [weak self] (state) in
            self?.nameLabel.text = state.state.rawValue
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
        idViewModel.id.delegate = self
        passwordViewModel.password.delegate = self
    }
}

extension SignUpViewController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activateTextField = textField
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == idViewModel.id {
            self.passwordViewModel.password.becomeFirstResponder()
        } else if textField == passwordViewModel.password {
            self.nameViewModel.name.becomeFirstResponder()
        } else {
            activateTextField = nil
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

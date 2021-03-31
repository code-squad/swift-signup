//
//  PasswordViewModel.swift
//  SignUp
//
//  Created by 박혜원 on 2021/03/31.
//

import UIKit
import Combine

class PasswordViewModel: NSObject, ValidCheckViewModel{
    
    
    @IBOutlet weak var password: UITextField!
    
    typealias State = PasswordValidState
    
    var isValid : State
    
    private var actionHandler : ControlActionClosure?
    private var cancellable : AnyCancellable?
    
    override init(){
        isValid = State.init()
        super.init()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(passwordTextFieldEditingChanged(textField:)),
            name: UITextField.textDidChangeNotification,
            object: nil)
        
        cancellable = isValid.objectWillChange.sink {
            self.actionHandler?(self.isValid)
        }
    }
    func checkValidation() -> Bool {
        guard let text = password.text else { return false }
        return ValidationCheckService.isValidPassword(input: text)
    }
    func bind(control : @escaping ControlActionClosure) {
        self.actionHandler = control
    }
    @objc func passwordTextFieldEditingChanged(textField : UITextField){
        if checkValidation() {
            isValid.setValid()
        } else {
            isValid.setInValid()
        }
    }
}

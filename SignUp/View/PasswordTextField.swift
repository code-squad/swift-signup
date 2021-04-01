//
//  PasswordTextField.swift
//  SignUp
//
//  Created by 박혜원 on 2021/04/01.
//

import UIKit
import Combine

class PasswordTextField : UITextField, ValidCheckProtocol {
    typealias ValidState = PasswordValidState
    
    var isValid = PasswordValidState.init()
    var handler : ControlActionClosure?
    private var cancellable : AnyCancellable?
    
    override init(frame : CGRect){
        super.init(frame: frame)
        setCancellable()
        addTarget()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setCancellable()
        addTarget()
    }
    func setCancellable(){
        cancellable = isValid.objectWillChange.sink { [weak self] in
            self?.handler?(self!.isValid)
        }
    }
    func checkValidation() -> ValidState.State {
        guard let text = self.text else { return .none }
        let result = ValidationCheckService.isValidPassword(input: text)
        return result
    }
    
    func bind(control: @escaping ControlActionClosure) {
        self.handler = control
    }
    func addTarget(){
        self.addTarget(self, action: #selector(PasswordTextField.textFieldDidBeginEditing(_:)), for: .editingChanged)
        self.addTarget(self, action: #selector(PasswordTextField.textFieldDidEndEditing(_:)), for: .editingDidEndOnExit)
        self.addTarget(self, action: #selector(PasswordTextField.textFieldShouldReturn(_:)), for: .editingDidEnd)
    }
}
extension PasswordTextField {
    
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 8
        textField.clipsToBounds = true
    }
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        let result = checkValidation()
        isValid.chageState(to: result)
    }
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if isValid.state == .valid {
            textField.layer.borderColor = UIColor.myGreen.cgColor
        } else {
            textField.layer.borderColor = UIColor.red.cgColor
        }
        return false
    }
}

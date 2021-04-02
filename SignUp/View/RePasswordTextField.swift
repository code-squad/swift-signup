//
//  RePasswordTextField.swift
//  SignUp
//
//  Created by 박혜원 on 2021/04/01.
//

import UIKit
import Combine

class RePasswordTextField: UITextField, ValidCheckProtocol {
    typealias ValidState = RePasswordValidState
    
    var isValid = RePasswordValidState.init()
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
        guard let text = self.text else { return .notEqual }
        let result = ValidationCheckService.isEqualPassword(to: text, from: "")
        return result
    }
    
    func bind(control: @escaping ControlActionClosure) {
        self.handler = control
    }
    func addTarget(){
        self.addTarget(self, action: #selector(RePasswordTextField.textFieldDidBeginEditing(_:)), for: .editingChanged)
        self.addTarget(self, action: #selector(RePasswordTextField.textFieldShouldReturn(_:)), for: .editingDidEnd)
    }
}
extension RePasswordTextField {
    
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 8
        textField.clipsToBounds = true
    }

    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let result = checkValidation()
        isValid.chageState(to: result)
        
        if isValid.state == .equal {
            textField.layer.borderColor = UIColor.myGreen.cgColor
        } else {
            textField.layer.borderColor = UIColor.red.cgColor
        }
        return false
    }
}

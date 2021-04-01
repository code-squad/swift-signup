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
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setCancellable()
    }
    func setCancellable(){
        cancellable = isValid.objectWillChange.sink { [weak self] in
            self?.handler?(self!.isValid)
        }
    }
    func checkValidation() -> Bool {
        guard let text = self.text else { return false }
        let result = ValidationCheckService.isValidPassword(input: text)
        return result
    }
    
    func bind(control: @escaping ControlActionClosure) {
        self.handler = control
    }
}

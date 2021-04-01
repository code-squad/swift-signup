//
//  NameViewModel.swift
//  SignUp
//
//  Created by 박혜원 on 2021/03/31.
//

import UIKit
import Combine

class NameViewModel: NSObject, ValidCheckViewModel {

    @IBOutlet weak var name: UITextField!
    
    typealias State = NameValidState
    
    var isValid : State
    
    private var actionHandler : ControlActionClosure?
    private var cancellable : AnyCancellable?
    
    override init(){
        isValid = State.init()
        super.init()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(idTextFieldEditingChanged(textField:)),
            name: UITextField.textDidEndEditingNotification,
            object: nil)
        
        cancellable = isValid.objectWillChange.sink {
            self.actionHandler?(self.isValid)
        }
    }
    
    func checkValidation() -> Bool {
        guard let text = name.text else { return false }
        return ValidationCheckService.isValidName(input: text)
    }
    func bind(control : @escaping ControlActionClosure) {
        self.actionHandler = control
    }
    @objc func idTextFieldEditingChanged(textField : UITextField){
        if checkValidation() {
            isValid.setValid()
        } else {
            isValid.setNotValid()
        }
    }
}

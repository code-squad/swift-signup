//
//  NameTextField.swift
//  SignUp
//
//  Created by 박혜원 on 2021/04/01.
//

import UIKit
import Combine

class NameTextField : UITextField, ValidCheckProtocol {
    
    typealias ValidState = NameValidState
    
    var isValid = NameValidState.init()
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
    func checkValidation() -> ValidState.State {
        guard let text = self.text else { return .inValid }
        let result = ValidationCheckService.isValidName(input: text)
        return result
    }
    
    func bind(control: @escaping ControlActionClosure) {
        self.handler = control
    }
}
//extension NameTextField : UITextFieldDelegate {
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        <#code#>
//    }
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        <#code#>
//    }
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        <#code#>
//    }
//}

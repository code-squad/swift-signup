//
//  SignUpViewModel.swift
//  SignUp
//
//  Created by 박혜원 on 2021/04/01.
//

import UIKit
import Combine

class SignUpViewModel: NSObject {
    @IBOutlet weak var id: IDTextField!
    @IBOutlet weak var password: PasswordTextField!
    @IBOutlet weak var repassword: UITextField!
    @IBOutlet weak var name: NameTextField!
    
    private var cancellable : AnyCancellable?
    
    override init(){
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(idTextDidEndEditing), name: IDTextField.textDidEndEditingNotification, object: id)
        NotificationCenter.default.addObserver(self, selector: #selector(passwordDidChange), name: PasswordTextField.textDidChangeNotification, object: password)
        NotificationCenter.default.addObserver(self, selector: #selector(NameDidEndEditing), name: NameTextField.textDidEndEditingNotification, object: name)
    }
    
    func setDelegate(_ view : UITextFieldDelegate){
        id.delegate = view
        password.delegate = view
        repassword.delegate = view
        name.delegate = view
    }
    
    @objc func idTextDidEndEditing(){
        let result = id.checkValidation()
        if result {
            id.isValid.chageState(to: .valid)
        } else {
            id.isValid.chageState(to: .inValid)
        }
    }
    @objc func passwordDidChange(){
        let result = password.checkValidation()
        if result {
            password.isValid.chageState(to: .valid)
        } else {
            password.isValid.chageState(to: .none)
        }
    }
    @objc func repasswordDidEndEditing(){
        
    }
    @objc func NameDidEndEditing(){
        let result = name.checkValidation()
        if result {
            name.isValid.chageState(to: .valid)
        } else {
            name.isValid.chageState(to: .inValid)
        }
    }
    
}

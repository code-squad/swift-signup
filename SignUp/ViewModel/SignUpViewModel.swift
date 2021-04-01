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
    
    override init(){
        super.init()
    
    }
    func setDelegate(_ view : UITextFieldDelegate){
        self.id.delegate = view
        self.password.delegate = view
        self.repassword.delegate = view
        self.name.delegate = view
    }
}

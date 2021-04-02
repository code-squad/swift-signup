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
    @IBOutlet weak var repassword: RePasswordTextField!
    @IBOutlet weak var name: NameTextField!
    
    override init(){
        super.init()
    
    }
}

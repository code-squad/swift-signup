//
//  UserRegisterForm.swift
//  swift-signup
//
//  Created by 박정하 on 2021/03/29.
//

import UIKit

class UserRegisterForm : UIView {
    private var userRegisterFormElements : [UserRegisterFormElement]
    private var ElementPos : CGRect!
    
    override init(frame : CGRect) {
        userRegisterFormElements = []
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        userRegisterFormElements = []
        super.init(coder: coder)
    }
    
    func addUserRegisterForm(element : UserRegisterFormElement){
        self.addSubview(element)
        self.userRegisterFormElements.append(element)
    }
    
    func currentCount() -> Int{
        userRegisterFormElements.count
    }
}

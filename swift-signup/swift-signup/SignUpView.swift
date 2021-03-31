//
//  signUpView.swift
//  swift-signup
//
//  Created by 박정하 on 2021/03/30.
//

import UIKit

class SignUpView : UIView {
    private let SignUpTitle : UILabel
    private let iDtitle : ObjectTitle
    private let idTextField : IDTextField
    private let idAlertMessage : AlertMessage
    private let passWordtitle : ObjectTitle
    private let passWordTextField : PasswordTextfield
    private let reEnterPasswordTitle : ObjectTitle
    private let reEnterPasswordTextField : ReEnterPasswordTextField
    private let nameTitle : ObjectTitle
    private let nameTextField : NameTextField
    
    override init(frame: CGRect) {
        SignUpTitle = UILabel.init(frame: CGRect(x: 136, y: 30, width: 104, height: 36))
        iDtitle = ObjectTitle.init(frame: CGRect(x: 36, y: 91, width: 36, height: 17), text: "아이디")
        idTextField = IDTextField.init(frame: CGRect(x: 36, y: 112, width: 302, height: 38))
        idAlertMessage = AlertMessage.init(frame: CGRect(x: 36, y: 151, width: 134, height: 15))
        passWordtitle = ObjectTitle.init(frame: CGRect(x: 36.5, y: 176, width: 48, height: 17), text: "비밀번호")
        passWordTextField = PasswordTextfield.init(frame: CGRect(x: 36.5, y: 197, width: 302, height: 38))
        reEnterPasswordTitle = ObjectTitle.init(frame: CGRect(x: 36.5, y: 259, width: 88, height: 17), text: "비밀번호 재확인")
        reEnterPasswordTextField = ReEnterPasswordTextField(frame: CGRect(x: 36.5, y: 280, width: 302, height: 38))
        nameTitle = ObjectTitle.init(frame: CGRect(x: 36.5, y: 337, width: 302, height: 38), text: "이름")
        nameTextField = NameTextField.init(frame : CGRect(x: 37, y: 358, width: 302, height: 38))
        
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(SignUpTitle)
        self.addSubview(iDtitle)
        self.addSubview(idTextField)
        self.addSubview(idAlertMessage)
        self.addSubview(passWordtitle)
        self.addSubview(passWordTextField)
        self.addSubview(reEnterPasswordTitle)
        self.addSubview(reEnterPasswordTextField)
        self.addSubview(nameTitle)
        self.addSubview(nameTextField)
    }
    
    required init?(coder: NSCoder) {
        SignUpTitle = UILabel.init(frame: CGRect(x: 136, y: 30, width: 104, height: 36))
        iDtitle = ObjectTitle.init(frame: CGRect(x: 36, y: 91, width: 36, height: 17), text: "아이디")
        idTextField = IDTextField.init(frame: CGRect(x: 36, y: 112, width: 302, height: 38))
        idAlertMessage = AlertMessage.init(frame: CGRect(x: 0, y: 39, width: 134, height: 15))
        passWordtitle = ObjectTitle.init(frame: CGRect(x: 36.5, y: 176, width: 48, height: 17), text: "비밀번호")
        passWordTextField = PasswordTextfield.init(frame: CGRect(x: 36.5, y: 197, width: 302, height: 38))
        reEnterPasswordTitle = ObjectTitle.init(frame: CGRect(x: 36.5, y: 259, width: 88, height: 17), text: "비밀번호 재확인")
        reEnterPasswordTextField = ReEnterPasswordTextField(frame: CGRect(x: 36.5, y: 280, width: 302, height: 38))
        nameTitle = ObjectTitle.init(frame: CGRect(x: 36.5, y: 337, width: 302, height: 38), text: "이름")
        nameTextField = NameTextField.init(frame : CGRect(x: 37, y: 358, width: 302, height: 38))
        
        super.init(coder: coder)
    }
}

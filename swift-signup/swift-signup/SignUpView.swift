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
    private let idTextField : CustomTextField
    private let idAlertMessage : AlertMessage
    private let passWordtitle : ObjectTitle
    private let passWordTextField : CustomTextField
    private let reEnterPasswordTitle : ObjectTitle
    private let reEnterPasswordTextField : CustomTextField
    private let reEnterPasswordAlertMessage : AlertMessage
    private let nameTitle : ObjectTitle
    private let nameTextField : CustomTextField
    
    override init(frame: CGRect) {
        SignUpTitle = UILabel.init(frame: CGRect(x: 136, y: 30, width: 104, height: 36))
        iDtitle = ObjectTitle.init(frame: CGRect(x: 36, y: 91, width: 36, height: 17), text: "아이디")
        idAlertMessage = AlertMessage.init(frame: CGRect(x: 36, y: 151, width: 134, height: 15))
        idTextField = CustomTextField.init(frame: CGRect(x: 36, y: 112, width: 302, height: 38), textfieldDelegate: IDTextFieldDelegate(alertMessage: idAlertMessage), isSecure: false)
        passWordtitle = ObjectTitle.init(frame: CGRect(x: 36.5, y: 176, width: 48, height: 17), text: "비밀번호")
        passWordTextField = CustomTextField.init(frame: CGRect(x: 36.5, y: 197, width: 302, height: 38), textfieldDelegate: PasswordTextFieldDelegate(), isSecure: true)
        reEnterPasswordTitle = ObjectTitle.init(frame: CGRect(x: 36.5, y: 259, width: 88, height: 17), text: "비밀번호 재확인")
        reEnterPasswordAlertMessage = AlertMessage.init(frame: CGRect(x: 37, y: 319, width: 144, height: 15))
        reEnterPasswordTextField = CustomTextField(frame: CGRect(x: 36.5, y: 280, width: 302, height: 38), textfieldDelegate: ReEnterPasswordTextFieldDelegate(passWordTextField: passWordTextField, alertMessage: reEnterPasswordAlertMessage), isSecure: true)
        
        nameTitle = ObjectTitle.init(frame: CGRect(x: 36.5, y: 337, width: 302, height: 38), text: "이름")
        nameTextField = CustomTextField.init(frame : CGRect(x: 37, y: 358, width: 302, height: 38), textfieldDelegate: NameTextFieldDelegate(),isSecure: false)
        
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(SignUpTitle)
        self.addSubview(iDtitle)
        self.addSubview(idTextField)
        self.addSubview(idAlertMessage)
        self.addSubview(passWordtitle)
        self.addSubview(passWordTextField)
        self.addSubview(reEnterPasswordTitle)
        self.addSubview(reEnterPasswordAlertMessage)
        self.addSubview(reEnterPasswordTextField)
        self.addSubview(nameTitle)
        self.addSubview(nameTextField)
    }
    
    required init?(coder: NSCoder) {
        SignUpTitle = UILabel.init(frame: CGRect(x: 136, y: 30, width: 104, height: 36))
        iDtitle = ObjectTitle.init(frame: CGRect(x: 36, y: 91, width: 36, height: 17), text: "아이디")
        idAlertMessage = AlertMessage.init(frame: CGRect(x: 0, y: 39, width: 134, height: 15))
        idTextField = CustomTextField.init(frame: CGRect(x: 36, y: 112, width: 302, height: 38), textfieldDelegate: IDTextFieldDelegate(alertMessage: idAlertMessage), isSecure: false)
        passWordtitle = ObjectTitle.init(frame: CGRect(x: 36.5, y: 176, width: 48, height: 17), text: "비밀번호")
        passWordTextField = CustomTextField.init(frame: CGRect(x: 36.5, y: 197, width: 302, height: 38), textfieldDelegate: PasswordTextFieldDelegate())
        reEnterPasswordTitle = ObjectTitle.init(frame: CGRect(x: 36.5, y: 259, width: 88, height: 17), text: "비밀번호 재확인")
        reEnterPasswordAlertMessage = AlertMessage.init(frame: CGRect(x: 37, y: 319, width: 144, height: 15))
        reEnterPasswordTextField = CustomTextField(frame: CGRect(x: 36.5, y: 280, width: 302, height: 38), textfieldDelegate: ReEnterPasswordTextFieldDelegate(passWordTextField: passWordTextField, alertMessage: reEnterPasswordAlertMessage))
        nameTitle = ObjectTitle.init(frame: CGRect(x: 36.5, y: 337, width: 302, height: 38), text: "이름")
        nameTextField = CustomTextField.init(frame : CGRect(x: 37, y: 358, width: 302, height: 38), textfieldDelegate: NameTextFieldDelegate(), isSecure: false)
        
        super.init(coder: coder)
    }
}

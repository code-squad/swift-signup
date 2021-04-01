//
//  ReEnterPasswordTextFieldDelegate.swift
//  swift-signup
//
//  Created by 박정하 on 2021/03/30.
//

import UIKit

class ReEnterPasswordTextFieldDelegate : NSObject, UITextFieldDelegate{
    let PassWordTextField : UITextField
    let alertMessage : AlertMessage
    
    init(passWordTextField : UITextField, alertMessage: AlertMessage){
        self.PassWordTextField = passWordTextField
        self.alertMessage = alertMessage
        super.init()
    }
    
    enum reEnterPasswordErrorCase : String{
        case Wrong = "비밀번호가 일치하지 않습니다", Correct = "비밀번호가 일치합니다"
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.systemBlue.cgColor
        textField.layer.borderWidth = 1
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text != PassWordTextField.text {
            alertMessage.UpdateAlertMessage(text: reEnterPasswordErrorCase.Wrong.rawValue)
        }
        else{
            alertMessage.UpdateCorrectMessage(text: reEnterPasswordErrorCase.Correct.rawValue)
        }
    }
}

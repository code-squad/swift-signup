//
//  ReEnterPasswordTextFieldDelegate.swift
//  swift-signup
//
//  Created by 박정하 on 2021/03/30.
//

import UIKit

class ReEnterPasswordTextFieldDelegate : NSObject, UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.systemBlue.cgColor
        textField.layer.borderWidth = 1
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
    }
    
    func isVaild(){
    }
}

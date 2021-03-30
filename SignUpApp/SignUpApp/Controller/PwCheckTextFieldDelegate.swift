//
//  PwCheckTextFieldDelegate.swift
//  SignUpApp
//
//  Created by sonjuhyeong on 2021/03/30.
//

import UIKit

class PwCheckTextFieldDelegate: TextFieldDelegate {
    
    var checkBool: Bool?
    
    override func textFieldDidEndEditing(_ textField: UITextField) {
        guard let check = checkBool else { return }
        if check == true {
            textField.layer.borderColor = UIColor.systemGreen.cgColor
        }else {
            textField.layer.borderColor = UIColor.systemRed.cgColor
        }
    }
    
}

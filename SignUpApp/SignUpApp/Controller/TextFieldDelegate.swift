//
//  TextFieldDelegate.swift
//  SignUpApp
//
//  Created by sonjuhyeong on 2021/03/30.
//

import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate {
    
     func textFieldDidBeginEditing(_ textField: UITextField) {
         textField.layer.borderColor = UIColor.systemBlue.cgColor
         textField.layer.borderWidth = 1.0
     }
     
     func textFieldDidEndEditing(_ textField: UITextField) {
         if textField.layer.borderColor ==  UIColor.systemBlue.cgColor {
             textField.layer.borderColor = UIColor.black.cgColor
         }
     }

     // 리턴키 델리게이트 처리
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         textField.resignFirstResponder()
         return true
     }
}

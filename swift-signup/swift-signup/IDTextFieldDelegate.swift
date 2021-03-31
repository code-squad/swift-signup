//
//  CustomTextFieldDelegate.swift
//  swift-signup
//
//  Created by 박정하 on 2021/03/30.
//

import UIKit

class IDTextFieldDelegate : NSObject, UITextFieldDelegate {
    enum regexCase : String {
        case Capital = "[A-Z]+", SpecialCharacter = "[a-z0-9_-]+"
    }
    
    enum IDErrorCase : String {
        case CapitalError = "대문자는 사용할 수 없습니다.", SpcialCharacterError = "사용할 수 없는 특수문자가 포함되어있습니다.", CharacterCountError = "최소 5~20자를 입력해야 합니다.", CorrectID = "사용 가능한 아이디입니다."
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
        guard let senderText = textField.text else { return }
        if senderText.count < 5 || senderText.count > 20{
            NotificationCenter.default.post(name: NSNotification.Name("UpdateIdAlertMessage"), object: IDErrorCase.CharacterCountError.rawValue)
        }
        else if senderText.isValidString(regex: regexCase.Capital.rawValue) {
            NotificationCenter.default.post(name: NSNotification.Name("UpdateIdAlertMessage"), object: IDErrorCase.CapitalError.rawValue)
        }
        else if senderText.getArrayAfterRegex(regex: regexCase.SpecialCharacter.rawValue) != [senderText]{
            NotificationCenter.default.post(name: NSNotification.Name("UpdateIdAlertMessage"), object: IDErrorCase.SpcialCharacterError.rawValue)
        }
        else{
            NotificationCenter.default.post(name: NSNotification.Name("CorrectId"), object: IDErrorCase.CorrectID.rawValue)
        }
    }
}

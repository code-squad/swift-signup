//
//  NameTextFieldDelegate.swift
//  SignUp
//
//  Created by 양준혁 on 2021/03/30.
//

import UIKit

class NameTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    private var nameLabel: UILabel
    var checker: () -> Bool?
    
    init(label: UILabel, completion: @escaping () -> Bool? ) {
        nameLabel = label
        checker = completion
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.blue.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let check = checker() else { return }
        if !check {
            textField.layer.borderColor = #colorLiteral(red: 0.9967475533, green: 0.03828956559, blue: 0.05758263916, alpha: 1)
            nameLabel.text = "이름은 필수 입력 항목입니다."
            nameLabel.textColor = #colorLiteral(red: 0.9967475533, green: 0.03828956559, blue: 0.05758263916, alpha: 1)
        } else {
            textField.layer.borderWidth = 0
            nameLabel.text = ""
        }
    }
    
}

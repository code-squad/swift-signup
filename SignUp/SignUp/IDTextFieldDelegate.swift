//
//  IDTextFieldDelegate.swift
//  SignUp
//
//  Created by 양준혁 on 2021/03/29.
//

import UIKit

class IDTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    private var state: IDTextFieldState?
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.blue.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        let extract = text.getArrayAfterRegex(regex: "[0-9a-z_-]+")[0]
        
        RequestManager.requestGet(id: extract) { (result) in
            if result == .exist {
                DispatchQueue.main.async {
                    textField.layer.borderColor = #colorLiteral(red: 0.9967475533, green: 0.03828956559, blue: 0.05758263916, alpha: 1)
                }
                self.state = IDTextFieldState.alreadyUse
            }
        }

        if extract != text || extract.count < 5 || extract.count > 20 {
            textField.layer.borderColor = #colorLiteral(red: 0.9967475533, green: 0.03828956559, blue: 0.05758263916, alpha: 1)
            state = IDTextFieldState.incorrect
        } else if extract == textField.text && text.count > 4 && text.count < 21 {
            textField.layer.borderColor = #colorLiteral(red: 0.1540483236, green: 0.6966413856, blue: 0.1375852525, alpha: 1)
            state = IDTextFieldState.correct
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "identifier"), object: state)

    }
}

enum IDTextFieldState {
    typealias RawValue = (String, UIColor)

    case incorrect
    case correct
    case alreadyUse
}


//
//  SignupTextFieldModel.swift
//  signup
//
//  Created by Song on 2021/03/29.
//

import UIKit

class SignUpTextFieldModel: NSObject {

    @IBOutlet var textFieldCollection: [UITextField]!
    
}

extension SignUpTextFieldModel: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(named: "PointBlue")?.cgColor
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(named: "PointGrey")?.cgColor
        
        if let nextField = findNextTextField(from: textField) {
            nextField.becomeFirstResponder()
        }
    }
    
    private func findNextTextField(from textField: UITextField) -> UITextField? {
        let currentIndex = textFieldCollection.firstIndex(of: textField) ?? Int.max
        let maxIndex = textFieldCollection.count - 1
        return maxIndex > currentIndex ? textFieldCollection[currentIndex + 1] : nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.endEditing(true)
    }
}

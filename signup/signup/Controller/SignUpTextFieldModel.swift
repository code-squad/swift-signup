//
//  SignupTextFieldModel.swift
//  signup
//
//  Created by Song on 2021/03/29.
//

import UIKit
//뷰 모델과 일반 모델
class SignUpTextFieldModel: NSObject {

    @IBOutlet var textFieldCollection: [UITextField]!
    @IBOutlet var infoLabelCollection: [UILabel]!
    private let validateManagerList: [ValidateManager]
    
    override init() {
        validateManagerList = [IDValidateManager(),
                               PasswordValidateManager(),
                               PasswordConfirmManager(),
                               UserNameValidateManager()]
        super.init()
    }
    
    enum ColorSet {
        static let blue = "PointBlue"
        static let red = "PointRed"
        static let green = "PointGreen"
        static let grey = "PointGrey"
    }
    
    func isAllFieldValidate() -> Bool {
//        for textField in textFieldCollection {
//            let validateManager = validateManagerList[textField]!
//
//        }
        return true
    }
    
    private func collectionIndex(for textField: UITextField) -> Int {
        return textFieldCollection.firstIndex(of: textField)!
    }
}

extension SignUpTextFieldModel: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.endEditing(true)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.layer.borderColor = UIColor(named: ColorSet.blue)?.cgColor
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let status = configureStatus(for: textField)
        changeInfoLabel(for: textField, with: status)
    }
    
    private func configureStatus(for textField: UITextField) -> Status {
        var status: Status
        let targetIdx = collectionIndex(for: textField)
        let validateManager = validateManagerList[targetIdx]
        
        if let passwordConfirmManager = validateManager as? PasswordConfirmManager {
            let password = textFieldCollection[1].text ?? ""
            let confirm = textField.text ?? ""
            status = passwordConfirmManager.check([password, confirm])
        } else {
            status = validateManager.check([textField.text ?? ""])
        }
        return status
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        let status = configureStatus(for: textField)
        changeInfoLabel(for: textField, with: status)
        
        if status.isValidated {
            if let nextField = findNextTextField(from: textField) {
                nextField.becomeFirstResponder()
            }
        } else {
            textField.becomeFirstResponder()
        }
    }
    
    private func changeInfoLabel(for textField: UITextField, with status: Status) {
        let targetIdx = collectionIndex(for: textField)
        let labelToChange = infoLabelCollection[targetIdx]
        
        let color = status.isValidated ? UIColor(named: ColorSet.green) : UIColor(named: ColorSet.red)
        labelToChange.textColor = color
        textField.layer.borderColor = color?.cgColor
        
        labelToChange.text = status.message
    }
    
    private func findNextTextField(from textField: UITextField) -> UITextField? {
        let currentIndex = textFieldCollection.firstIndex(of: textField) ?? Int.max
        let maxIndex = textFieldCollection.count - 1
        return maxIndex > currentIndex ? textFieldCollection[currentIndex + 1] : nil
    }
}

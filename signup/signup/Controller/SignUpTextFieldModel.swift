//
//  SignupTextFieldModel.swift
//  signup
//
//  Created by Song on 2021/03/29.
//

import UIKit

class SignUpTextFieldModel: NSObject {

    @IBOutlet var textFieldCollection: [UITextField]!
    @IBOutlet var infoLabelCollection: [UILabel]!
    
    private let okMessage = ["사용 가능한 아이디입니다",
                             "안전한 비밀번호입니다",
                             "비밀번호가 일치합니다",
                             "좋은 이름이네요 :)"]
    
    private let signUpErrorManager: ErrorManager
    
    override init() {
        signUpErrorManager = SignUpErrorManager()
        super.init()
    }
    
    enum ColorSet {
        static let blue = "PointBlue"
        static let red = "PointRed"
        static let green = "PointGreen"
        static let grey = "PointGrey"
    }
    
    func isAllFieldValidate() -> Bool {
        for textField in textFieldCollection {
            if errorMessage(for: textField) != nil {
                return false
            }
        }
        return true
    }
    
    private func errorMessage(for textField: UITextField) -> String? {
        let input = textField.text ?? ""
        let index = collectionIndex(for: textField)
        
        switch index {
        case 0:
            return signUpErrorManager.id(input)
        case 1:
            return signUpErrorManager.password(input)
        case 2:
            let password = textFieldCollection[1].text ?? ""
            return signUpErrorManager.passwordDoubleCheck(first: password, second: input)
        case 3:
            return signUpErrorManager.name(input)
        default:
            return nil
        }
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let errorMessage = errorMessage(for: textField) {
            updateToErrorState(for: textField, with: errorMessage)
        } else {
            updateToValidateState(for: textField)
        }
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let errorMessage = errorMessage(for: textField) {
            updateToErrorState(for: textField, with: errorMessage)
            textField.becomeFirstResponder()
        } else {
            updateToValidateState(for: textField)
            if let nextField = findNextTextField(from: textField) {
                nextField.becomeFirstResponder()
            }
        }
    }
    
    private func updateToErrorState(for textField: UITextField, with errorMessage: String) {
        let targetIdx = collectionIndex(for: textField)
        let labelToChange = infoLabelCollection[targetIdx]
        
        labelToChange.text = errorMessage
        labelToChange.textColor = UIColor(named: ColorSet.red)
        textField.layer.borderColor = UIColor(named: ColorSet.red)?.cgColor
    }
    
    private func updateToValidateState(for textField: UITextField) {
        let targetIdx = collectionIndex(for: textField)
        let labelToChange = infoLabelCollection[targetIdx]
        
        labelToChange.text = okMessage[targetIdx]
        labelToChange.textColor = UIColor(named: ColorSet.green)
        textField.layer.borderColor = UIColor(named: ColorSet.grey)?.cgColor
    }
    
    private func findNextTextField(from textField: UITextField) -> UITextField? {
        let currentIndex = textFieldCollection.firstIndex(of: textField) ?? Int.max
        let maxIndex = textFieldCollection.count - 1
        return maxIndex > currentIndex ? textFieldCollection[currentIndex + 1] : nil
    }
}

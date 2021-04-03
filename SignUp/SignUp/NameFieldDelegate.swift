//
//  NameFieldDelegate.swift
//  SignUp
//
//  Created by Ador on 2021/03/30.
//

import UIKit

class NameFieldDelegate: NSObject, UITextFieldDelegate {
    private let presenter: NamePresenter
    
    init(presenter: NamePresenter) {
        self.presenter = presenter
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        presenter.activate()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        presenter.unActivate()
        guard let text = textField.text?.replacingOccurrences(of: " ", with: ""), !text.isEmpty else {
            presenter.updateLabel(with: NameCheck.empty.rawValue)
            return
        }
        presenter.updateLabel(with: NameCheck.notEmpty.rawValue)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

enum NameCheck: String {
    case empty = "이름은 필수 입력 항목입니다."
    case notEmpty = ""
}

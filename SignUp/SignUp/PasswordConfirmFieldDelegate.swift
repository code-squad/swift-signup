//
//  PasswordConfirmFieldDelegate.swift
//  SignUp
//
//  Created by Ador on 2021/03/30.
//

import UIKit

class PasswordConfirmFieldDelegate: NSObject, UITextFieldDelegate {
    var passwordConfirmHandler: (() -> Bool)?
    var firstResponserHandler: (() -> Void)?
    private let presenter: PasswordConfirmPresenter
    
    init(presenter: PasswordConfirmPresenter) {
        self.presenter = presenter
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        presenter.activate()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        presenter.unActivate()
        guard let text = textField.text?.replacingOccurrences(of: " ", with: ""), !text.isEmpty else {
            return
        }
        guard let confirm = passwordConfirmHandler else {
            return
        }
        if confirm() {
            presenter.updateLabel(with: PasswordCheck.correspond.rawValue)
        } else {
            presenter.updateLabel(with: PasswordCheck.notCorrespond.rawValue)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstResponserHandler?()
        return true
    }
}

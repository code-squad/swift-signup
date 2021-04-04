//
//  PasswordConfirmFieldDelegate.swift
//  SignUp
//
//  Created by Ador on 2021/03/30.
//

import UIKit

class PasswordConfirmFieldDelegate: NSObject, UITextFieldDelegate {
    private var passwordConfirmHandler: () -> Bool
    private var firstResponserHandler: () -> Void
    private let presenter: PasswordConfirmPresenter
    
    init(presenter: PasswordConfirmPresenter, firstResponserHandler: @escaping () -> Void, passwordConfirmHandler: @escaping () -> Bool) {
        self.presenter = presenter
        self.firstResponserHandler = firstResponserHandler
        self.passwordConfirmHandler = passwordConfirmHandler
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        presenter.activate()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        presenter.unActivate()
        guard let text = textField.text?.replacingOccurrences(of: " ", with: ""), !text.isEmpty else {
            return
        }
        if passwordConfirmHandler() {
            presenter.updateLabel(with: PasswordCheck.correspond.rawValue, status: true)
        } else {
            presenter.updateLabel(with: PasswordCheck.notCorrespond.rawValue, status: false)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstResponserHandler()
        return true
    }
}

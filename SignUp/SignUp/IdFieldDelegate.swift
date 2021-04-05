//
//  SignUpDelegate.swift
//  SignUp
//
//  Created by Ador on 2021/03/29.
//

import UIKit

class IdFieldDelegate: NSObject, UITextFieldDelegate {
    enum IdCheck {
        static let available = "사용 가능한 아이디입니다."
        static let alreadyUsing = "이미 사용 중인 아이디입니다."
        static let unavailable = "5~20자의 영문 소문자, 숫자와 특수기호(_)(-)만 사용 가능합니다."
    }
    
    private let firstResponserHandler: () -> Void
    private let presenter: Presentable
    
    init(presenter: Presentable, handler: @escaping (() -> Void)) {
        self.presenter = presenter
        self.firstResponserHandler = handler
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        presenter.activate()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        presenter.unActivate()
        guard let text = textField.text?.replacingOccurrences(of: " ", with: ""), !text.isEmpty else {
            return
        }
        if !FormatManager.match(format: FormatManager.Format.id, with: text) {
            presenter.updateLabel(with: IdCheck.unavailable, status: false)
        } else {
            ValidateManager.validate(for: text) { [weak self] result in
                switch result {
                case .success(_):
                    self?.presenter.updateLabel(with: IdCheck.available, status: true)
                case .failure(_):
                    self?.presenter.updateLabel(with: IdCheck.alreadyUsing, status: false)
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstResponserHandler()
        return true
    }
}


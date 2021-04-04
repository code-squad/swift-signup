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
    
    var firstResponserHandler: (() -> Void)?
    private let presenter: IdPresenter
    
    init(presenter: IdPresenter) {
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
        if !FormatManager.match(format: FormatManager.Format.id, with: text) {
            presenter.updateLabel(with: IdCheck.unavailable)
        } else {
            ValidateManager.validate(for: text) { [weak self] result in
                switch result {
                case .success(_):
                    self?.presenter.updateLabel(with: IdCheck.available)
                case .failure(_):
                    self?.presenter.updateLabel(with: IdCheck.alreadyUsing)
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstResponserHandler?()
        return true
    }
}


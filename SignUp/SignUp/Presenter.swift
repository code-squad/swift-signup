//
//  Presenter.swift
//  SignUp
//
//  Created by Ador on 2021/04/03.
//

import UIKit

protocol SignUpView {
    var field: UITextField { get set }
    var label: UILabel { get set }
}

protocol Presentable {
    var view: SignUpView? { get set }
}

extension Presentable {
    mutating func setView(_ view: SignUpView) {
        self.view = view
        view.label.text = ""
    }
    
    func activate() {
        view?.field.layer.borderWidth = 1
        view?.field.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    func unActivate() {
        view?.field.layer.borderWidth = 0
    }
    
    func updateLabel(with message: String, status: Bool) {
        DispatchQueue.main.async {
            view?.label.text = message
            view?.label.textColor = status ? .systemGreen : .systemRed
        }
    }
}

class IdViewPresenter: Presentable {
    var view: SignUpView?
}

class PasswordViewPresenter: Presentable {
    var view: SignUpView?
}

class PasswordConfirmViewPresenter: Presentable {
    var view: SignUpView?
}

class NameViewPresenter: Presentable {
    var view: SignUpView?
}

//
//  Presenter.swift
//  SignUp
//
//  Created by Ador on 2021/04/03.
//

import UIKit

class IdPresenter {
    weak var view: IdView?
    
    func setView(_ view: IdView) {
        self.view = view
    }
    
    func unActivate() {
        view?.field.layer.borderWidth = 0
    }
    
    func activate() {
        view?.field.layer.borderWidth = 1
        view?.field.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    func updateLabel(with message: String) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.label.text = message
            self?.view?.label.textColor = .systemRed
        }
    }
}

class PasswordPresenter {
    weak var view: PasswordView?
    
    func setView(_ view: PasswordView) {
        self.view = view
    }
    
    func unActivate() {
        view?.field.layer.borderWidth = 0
    }
    
    func activate() {
        view?.field.layer.borderWidth = 1
        view?.field.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    func updateLabel(with message: String) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.label.text = message
            self?.view?.label.textColor = .systemRed
        }
    }
}

class PasswordConfirmPresenter {
    weak var view: PasswordConfirmView?
    
    func setView(_ view: PasswordConfirmView) {
        self.view = view
    }
    
    func unActivate() {
        view?.field.layer.borderWidth = 0
    }
    
    func activate() {
        view?.field.layer.borderWidth = 1
        view?.field.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    func updateLabel(with message: String) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.label.text = message
            self?.view?.label.textColor = .systemRed
        }
    }
}

class NamePresenter {
    weak var view: NameView?
    
    func setView(_ view: NameView) {
        self.view = view
    }
    
    func unActivate() {
        view?.field.layer.borderWidth = 0
    }
    
    func activate() {
        view?.field.layer.borderWidth = 1
        view?.field.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    func updateLabel(with message: String) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.label.text = message
            self?.view?.label.textColor = .systemRed
        }
    }
}


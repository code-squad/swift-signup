//
//  ViewController.swift
//  SignUp
//
//  Created by Ador on 2021/03/29.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var idView: IdView!
    @IBOutlet weak var passwordView: PasswordView!
    @IBOutlet weak var passwordConfirmView: PasswordConfirmView!
    @IBOutlet weak var nameView: NameView!
    
    private let idpresenter = IdPresenter()
    private let passwordPresenter = PasswordPresenter()
    private let passwordConfirmPresenter = PasswordConfirmPresenter()
    private let namePresenter = NamePresenter()
    
    private lazy var idFieldDelegate = IdFieldDelegate(presenter: idpresenter)
    private lazy var passwordFieldDelegate = PasswordFieldDelegate(presenter: passwordPresenter)
    private lazy var passwordConfirmFieldDelegate = PasswordConfirmFieldDelegate(presenter: passwordConfirmPresenter)
    private lazy var nameFieldDelegate = NameFieldDelegate(presenter: namePresenter)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idpresenter.setView(idView)
        idView.field.delegate = idFieldDelegate
        idView.field.becomeFirstResponder()
        
        passwordPresenter.setView(passwordView)
        passwordView.field.delegate = passwordFieldDelegate
        
        passwordConfirmPresenter.setView(passwordConfirmView)
        passwordConfirmView.field.delegate = passwordConfirmFieldDelegate
        
        namePresenter.setView(nameView)
        nameView.field.delegate = nameFieldDelegate
        
        setFirstResponderHandler()
        passwordConfirmHandler()
    }
 
    func passwordConfirmHandler() {
        passwordConfirmFieldDelegate.passwordConfirmHandler = { [weak self] in
            return self?.passwordView.field.text == self?.passwordConfirmView.field.text
        }
    }
    
    private func setFirstResponderHandler() {
        idFieldDelegate.firstResponserHandler = { [weak self] in
            self?.passwordView.field.becomeFirstResponder()
        }
        passwordFieldDelegate.firstResponserHandler = { [weak self] in
            self?.passwordConfirmView.field.becomeFirstResponder()
        }
        passwordConfirmFieldDelegate.firstResponserHandler = { [weak self] in
            self?.nameView.field.becomeFirstResponder()
        }
    }
}

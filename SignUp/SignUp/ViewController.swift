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
    
    private var idViewPresenter = IdViewPresenter()
    private var passwordViewPresenter = PasswordViewPresenter()
    private var passwordConfirmViewPresenter = PasswordConfirmViewPresenter()
    private var nameViewPresenter = NameViewPresenter()
    
    private lazy var idFieldDelegate
        = IdFieldDelegate(presenter: idViewPresenter, handler: { [weak self] in
        self?.passwordView.input.becomeFirstResponder()})
    private lazy var passwordFieldDelegate
        = PasswordFieldDelegate(presenter: passwordViewPresenter, handler: { [weak self] in
        self?.passwordConfirmView.input.becomeFirstResponder()})
    private lazy var passwordConfirmFieldDelegate
        = PasswordConfirmFieldDelegate(presenter: passwordConfirmViewPresenter,
                                       firstResponserHandler: { [weak self] in
                                        self?.nameView.input.becomeFirstResponder()},
                                       passwordConfirmHandler: { [weak self] in
                                        return self?.passwordView.input.text == self?.passwordConfirmView.input.text})
    private lazy var nameFieldDelegate = NameFieldDelegate(presenter: nameViewPresenter)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idViewPresenter.setView(idView)
        idView.input.delegate = idFieldDelegate
        idView.input.becomeFirstResponder()
        
        passwordViewPresenter.setView(passwordView)
        passwordView.input.delegate = passwordFieldDelegate
        
        passwordConfirmViewPresenter.setView(passwordConfirmView)
        passwordConfirmView.input.delegate = passwordConfirmFieldDelegate
        
        nameViewPresenter.setView(nameView)
        nameView.input.delegate = nameFieldDelegate
    }
}

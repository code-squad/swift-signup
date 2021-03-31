//
//  ViewController.swift
//  SignUp
//
//  Created by HOONHA CHOI on 2021/03/29.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet weak var idStackView: SignUpStackView!
    @IBOutlet weak var passwordStackView: SignUpStackView!
    @IBOutlet weak var passwordConfirmStackView: SignUpStackView!
    @IBOutlet weak var nameStackView: SignUpStackView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    private var cancellable = Set<AnyCancellable>()
    private var viewModel = SignUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBind()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
    }
    
    func configureBind() {

        idStackView.textField.textPublisher.assign(to: &viewModel.idViewModel.$idText)
        passwordStackView.textField.textPublisher.assign(to: &viewModel.$passwordText)
        
        passwordConfirmStackView.textField.textPublisher
            .assign(to: &viewModel.$passwordConfirmText)
        nameStackView.textField.textPublisher
            .assign(to: &viewModel.$nameText)
        
        viewModel.isIdMatchValid.sink { state in
            self.idStackView.setText(state.description)
            state == .valid ? self.idStackView.succeed() : self.idStackView.fail()
        }.store(in: &cancellable)
        
        viewModel.isMatchPasswordValid.sink { state in
            self.passwordConfirmStackView.setText(state.description)
            state == .valid ? self.passwordConfirmStackView.succeed() : self.passwordConfirmStackView.fail()
        }.store(in: &cancellable)
        
        viewModel.isPasswordValid.sink { state in
            self.passwordStackView.setText(state.description)
            state == .valid ? self.passwordStackView.succeed() : self.passwordStackView.fail()
        }.store(in: &cancellable)
        
        viewModel.isNameValid.sink { state in
            self.nameStackView.setText(state.description)
            state == .valid ? self.nameStackView.succeed() : self.nameStackView.fail()
        }.store(in: &cancellable)
        
        viewModel.isInputValid.receive(on: RunLoop.main)
            .assign(to: \.isEnabled, on: nextButton)
            .store(in: &cancellable)
    }
}




//
//  ViewController.swift
//  SignUp
//
//  Created by HOONHA CHOI on 2021/03/29.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet weak var idTextField: InputTextField!
    @IBOutlet weak var passwordTextField: InputTextField!
    @IBOutlet weak var passwordConfirmTextField: InputTextField!
    @IBOutlet weak var nameTextField: InputTextField!
    
    @IBOutlet weak var idValidLabel: MessageLabel!
    @IBOutlet weak var passwordValidLabel: MessageLabel!
    @IBOutlet weak var passwordConfirmVaildLabel: MessageLabel!
    @IBOutlet weak var nameValidLabel: MessageLabel!
    
    @IBOutlet weak var nextButton: UIButton!
    
    var cancellable = Set<AnyCancellable>()
    var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBind()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
    }
    
    func configureBind() {

        idTextField.textPublisher
            .assign(to: &viewModel.$idText)
        passwordTextField.textPublisher
            .assign(to: &viewModel.$passwordText)
        passwordConfirmTextField.textPublisher
            .assign(to: &viewModel.$passwordConfirmText)
        nameTextField.textPublisher
            .assign(to: &viewModel.$nameText)
        
        viewModel.isIdMatchValid.sink { state in
            self.idValidLabel.setText(state.description)
            switch state {
            case .notStandard, .idExist :
                self.idValidLabel.fail()
                self.idTextField.fail()
            case .valid :
                self.idValidLabel.succeed()
                self.idTextField.succeed()
            }
        }.store(in: &cancellable)
        
        viewModel.isMatchPasswordValid.sink { state in
            self.passwordConfirmVaildLabel.setText(state.description)
            switch state {
            case .notEqual :
                self.passwordConfirmVaildLabel.fail()
                self.passwordConfirmTextField.fail()
            case .valid :
                self.passwordConfirmVaildLabel.succeed()
                self.passwordConfirmTextField.succeed()
            }
        }.store(in: &cancellable)
        
        viewModel.isPasswordValid.sink { state in
            self.passwordValidLabel.setText(state.description)
            switch state {
            case .notEnoughCount, .notNumber, .notUpperWord, .notSymbol :
                self.passwordValidLabel.fail()
                self.passwordTextField.fail()
            case .valid :
                self.passwordValidLabel.succeed()
                self.passwordTextField.succeed()
            }
        }.store(in: &cancellable)
        
        
        viewModel.isNameValid.sink { state in
            self.nameValidLabel.setText(state.description)
            switch state {
            case .empty :
                self.nameValidLabel.fail()
                self.nameTextField.fail()
            case .valid :
                self.nameValidLabel.succeed()
                self.nameTextField.succeed()
            }
        }.store(in: &cancellable)
        
        viewModel.isInputValid.receive(on: RunLoop.main)
            .assign(to: \.isEnabled, on: nextButton)
            .store(in: &cancellable)
    }
}




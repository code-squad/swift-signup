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
    
    @IBOutlet weak var idValidLabel: UILabel!
    @IBOutlet weak var passwordValidLabel: UILabel!
    @IBOutlet weak var passwordConfirmVaildLabel: UILabel!
    @IBOutlet weak var nameValidLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    
    var cancellable = Set<AnyCancellable>()
    var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBind()
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
        
        viewModel.isIdMatchValid.sink { (value) in
            self.idValidLabel.text = value.description
            switch value {
            case .notStandard, .idExist :
                self.idValidLabel.textColor = .red
                self.idTextField.fail()
            case .valid :
                self.idValidLabel.textColor = .systemGreen
                self.idTextField.succeed()
            }
        }.store(in: &cancellable)
        
        viewModel.isMatchPasswordValid.sink { (value) in
            self.passwordConfirmVaildLabel.text = value.description
            switch value {
            case .notEqual :
                self.passwordConfirmVaildLabel.textColor = .red
                self.passwordConfirmTextField.fail()
            case .valid :
                self.passwordConfirmVaildLabel.textColor = .systemGreen
                self.passwordConfirmTextField.succeed()
            }
        }.store(in: &cancellable)
        
        viewModel.isPasswordValid.sink { (value) in
            self.passwordValidLabel.text = value.description
            switch value {
            case .notEnoughCount,.notNumber,.notUpperWord,.notSymbol :
                self.passwordValidLabel.textColor = .red
                self.passwordTextField.fail()
            case .valid :
                self.passwordValidLabel.textColor = .systemGreen
                self.passwordTextField.succeed()
            }
        }.store(in: &cancellable)
        
        
        viewModel.isNameValid.sink { value in
            self.nameValidLabel.text = value.description
            switch value {
            case .empty :
                self.nameValidLabel.textColor = .red
                self.nameTextField.fail()
            case .valid :
                self.nameValidLabel.textColor = .none
                self.nameTextField.succeed()
            }
        }.store(in: &cancellable)
        
        viewModel.allValid.receive(on: RunLoop.main)
            .assign(to: \.isEnabled, on: nextButton)
            .store(in: &cancellable)
    }
}




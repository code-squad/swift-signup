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
        bindUI()
    }
    
    func bindUI() {

        idTextField.textPublisher
            .assign(to: &viewModel.$idText)
        passwordTextField.textPublisher
            .assign(to: &viewModel.$passwordText)
        passwordConfirmTextField.textPublisher
            .assign(to: &viewModel.$passwordConfirmText)
        nameTextField.textPublisher
            .assign(to: &viewModel.$nameText)
        
        viewModel.isMatchPassword.sink { (value) in
        }.store(in: &cancellable)
        
        viewModel.passwordLabel.sink { (value) in
            self.passwordValidLabel.text = value.description
            switch value {
            case .notEnoughCount,.notNumber,.notUpperWord,.notSymbol :
                self.passwordValidLabel.textColor = .red
                self.passwordTextField.fail()
            case .valid :
                self.passwordValidLabel.textColor = .green
                self.passwordTextField.succeed()
            }
        }.store(in: &cancellable)
        
//        viewModel.$isIdValid.sink { [weak self] (bool) in
            //guard let self = self else { return }
            //self.idValidLabel.text = "사용가능합니다"
//        }.store(in: &cancellable)
        
    }
}




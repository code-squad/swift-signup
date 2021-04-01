//
//  PrivateDataViewController.swift
//  SignUp
//
//  Created by HOONHA CHOI on 2021/04/01.
//

import UIKit
import Combine

class PrivateDataViewController: BaseViewController {

    @IBOutlet weak var emailStackView: SignUpStackView!
    @IBOutlet weak var phoneStackView: SignUpStackView!
    
    private var cancellable = Set<AnyCancellable>()
    private var privateDataViewModel = PrivateDataViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBind()
    }
    
    func configureBind() {
        emailStackView.textField.textPublisher.assign(to: &privateDataViewModel.emailViewModel.$emailText)
        phoneStackView.textField.textPublisher.assign(to: &privateDataViewModel.phoneViewModel.$phoneText)
        
        privateDataViewModel.isEmailMatchValid.sink { (state) in
            self.emailStackView.setText(state.message)
            self.emailStackView.updateUI(state.isValid())
        }.store(in: &cancellable)
        
        privateDataViewModel.isPhoneValid.sink { (state) in
            self.phoneStackView.setText(state.message)
            self.phoneStackView.updateUI(state.isValid())
        }.store(in: &cancellable)
    }
    
    @IBAction func goBackButtonTouched(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

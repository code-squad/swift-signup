//
//  PrivateDataViewModel.swift
//  SignUp
//
//  Created by HOONHA CHOI on 2021/04/01.
//

import Foundation
import Combine

class PrivateDataViewModel {
    
    var emailViewModel : EmailViewModel
    var phoneViewModel : PhoneViewModel
    
    var isEmailMatchValid : AnyPublisher<EmailState, Never>
    var isPhoneValid : AnyPublisher<PhoneState, Never>
    
    init() {
        emailViewModel = EmailViewModel()
        phoneViewModel = PhoneViewModel()
        
        isEmailMatchValid = emailViewModel.isValid
        isPhoneValid = phoneViewModel.isValid
    }
    
    var isInputValid : AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isEmailMatchValid, isPhoneValid)
            .map { $0 == .valid && $1 == .valid  }
            .eraseToAnyPublisher()
    }
    
}

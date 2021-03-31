//
//  ViewModel.swift
//  SignUp
//
//  Created by HOONHA CHOI on 2021/03/29.
//

import Foundation
import Combine

class SignUpViewModel {
    
    @Published var idText = ""
    @Published var passwordText = ""
    @Published var passwordConfirmText = ""
    @Published var nameText = ""
    
    private var cancellable = Set<AnyCancellable>()
    
    var idViewModel : IdViewModel
    
    var isIdMatchValid : AnyPublisher<IdState, Never>
    
    init() {
        idViewModel = IdViewModel()
        
        isIdMatchValid = idViewModel.isIdMatchValid
    }
    
    var isInputValid : AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(idPasswordInputValid, passwordConfirmNameInputValid)
            .map { $0 == true && $1 == true }
            .eraseToAnyPublisher()
    }
    
    
    
//    var isIdMatchValid : AnyPublisher<IdState , Never> {
//        Publishers.Zip(
//            idViewModel.setTextRule,idViewModel.isIdexist)
//            .map {
//                if $0 { print(" notstandard \($0) \($1)")
//                    return IdState.notStandard}
//                if $1 { print(" idexist \($1) \($0)")
//                    return IdState.idExist }
//                print($0 , $1)
//                return IdState.valid
//            }.eraseToAnyPublisher()
//    }
    
    var isPasswordValid : AnyPublisher<PasswordState, Never> {
        Publishers.Zip4(isPasswordCount, isPasswordUpperword, isPasswordNumber, isPasswordSymbol)
            .map {
                if $0 { return PasswordState.notEnoughCount }
                if $1 { return PasswordState.notUpperWord }
                if $2 { return PasswordState.notNumber }
                if $3 { return PasswordState.notSymbol }
                return PasswordState.valid
            }
            .eraseToAnyPublisher()
    }
    
    var isMatchPasswordValid : AnyPublisher<PasswordConfirmState, Never> {
        $passwordConfirmText
            .dropFirst()
            .combineLatest(self.$passwordText){
            return $0 == $1 ? PasswordConfirmState.valid : PasswordConfirmState.notEqual
        }.eraseToAnyPublisher()
    }
    
    var isNameValid : AnyPublisher<NameState, Never> {
        $nameText
            .dropFirst()
            .map { $0.isEmpty ? NameState.empty : NameState.valid }
            .eraseToAnyPublisher()
    }
    
    
    private var isPasswordCount : AnyPublisher<Bool, Never> {
        $passwordText
            .dropFirst()
            .map{ $0.count < 7 || $0.count > 16 }
            .eraseToAnyPublisher()
    }
    
    private var isPasswordUpperword : AnyPublisher<Bool, Never> {
        let pattern = "[A-Z]+"
        return $passwordText
            .dropFirst()
            .map{ $0.range(of: pattern, options: .regularExpression) == nil }
            .eraseToAnyPublisher()
    }
    
    private var isPasswordNumber : AnyPublisher<Bool, Never> {
        let pattern = "[0-9]+"
        return $passwordText
            .dropFirst()
            .map{ $0.range(of: pattern, options: .regularExpression) == nil }
            .eraseToAnyPublisher()
    }
    
    private var isPasswordSymbol : AnyPublisher<Bool, Never> {
        let pattern = "[!@#$%]+"
        return $passwordText
            .dropFirst()
            .map{ $0.range(of: pattern, options: .regularExpression) == nil }
            .eraseToAnyPublisher()
    }
    
    private var idPasswordInputValid : AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isIdMatchValid, isPasswordValid)
            .map { $0 == .valid && $1 == .valid }
            .eraseToAnyPublisher()
    }
    
    private var passwordConfirmNameInputValid : AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isMatchPasswordValid, isNameValid)
            .map { $0 == .valid && $1 == .valid }
            .eraseToAnyPublisher()
    }
}

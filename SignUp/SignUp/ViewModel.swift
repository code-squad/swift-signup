//
//  ViewModel.swift
//  SignUp
//
//  Created by HOONHA CHOI on 2021/03/29.
//

import Foundation
import Combine

enum PasswordStatus : CustomStringConvertible {
    case notEnoughCount
    case notUpperWord
    case notNumber
    case notSymbol
    
    case valid
    
    var description: String {
      switch self {
      case .notEnoughCount:
        return "8자 이상 16자 이하로 입력해주세요"
      case .notUpperWord:
        return "영문 대문자 최소 1자 이상 포함"
      case .notNumber:
        return "숫자를 최소 1자 이상 포함"
      case .notSymbol:
        return "특수문자를 최소 1자 이상 포함"
      case .valid :
        return "안전한 비밀번호 입니다"
      }
    }
}

enum PasswordConfirmStatus : CustomStringConvertible {
    case notEqual
    case valid
    
    var description: String {
      switch self {
      case .notEqual:
        return "비밀번호가 일치하지 않습니다"
      case .valid :
        return "비밀번호가 일치합니다"
      }
    }
}



class ViewModel {
    
    @Published var idText = ""
    @Published var passwordText = ""
    @Published var passwordConfirmText = ""
    @Published var nameText = ""
    
    @Published var isIdValid = false
    @Published var isPasswordValid = false
    @Published var isPasswordConfirmValid = false
    @Published var isNameValid = false
    
    private var cancellable = Set<AnyCancellable>()
    
    var isMatchPassword : AnyPublisher<PasswordConfirmStatus, Never> {
        $passwordConfirmText
            .dropFirst()
            .combineLatest(self.$passwordText){
            return $0 == $1 ? PasswordConfirmStatus.valid : PasswordConfirmStatus.notEqual
        }.eraseToAnyPublisher()
    }
    
    var isPasswordValidState : AnyPublisher<PasswordStatus, Never> {
        Publishers.Zip4(isPasswordCount, isPasswordUpperword, isPasswordNumber, isPasswordSymbol)
            .map {
                if $0 { return PasswordStatus.notEnoughCount }
                if $1 { return PasswordStatus.notUpperWord }
                if $2 { return PasswordStatus.notNumber }
                if $3 { return PasswordStatus.notSymbol }
                return PasswordStatus.valid
            }
            .eraseToAnyPublisher()
    }
    
    var isNameEmpty : AnyPublisher<Bool, Never> {
        $nameText
            .dropFirst()
            .map { $0.isEmpty }
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
    
    func validateId(_ string : String) -> Bool {
        let patten = "^[a-z0-9_-]{5,20}$"
        return string.range(of: patten,options: [.regularExpression]) != nil
    }

    func validateName(_ string : String) -> Bool {
        return !string.isEmpty
    }
    
}

//
//  ViewModel.swift
//  SignUp
//
//  Created by HOONHA CHOI on 2021/03/29.
//

import Foundation
import Combine

enum PasswordState : CustomStringConvertible {
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

enum PasswordConfirmState : CustomStringConvertible {
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


enum IdState : CustomStringConvertible {
    case idExist
    case notStandard
    case valid
    
    var description: String {
      switch self {
      case .idExist:
        return "이미 사용중인 아이디입니다"
      case .notStandard :
        return "5~20자의 영문 소문자, 숫자와 특수기호(_)(-) 만 사용 가능합니다"
      case .valid :
        return "사용 가능한 아이디입니다"
      }
    }
}

enum NameState : CustomStringConvertible {
    case empty
    case valid
    
    var description: String {
      switch self {
      case .empty:
        return "이름은 필수 입력 항목입니다"
      case .valid :
        return ""
      }
    }
}


class ViewModel {
    
    @Published var idText = ""
    @Published var passwordText = ""
    @Published var passwordConfirmText = ""
    @Published var nameText = ""
    
    private var cancellable = Set<AnyCancellable>()
    private var service : Service

    var allValid : AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(namePasswordInputValid, passwordConfirmNameInputValid)
            .map { $0 == true && $1 == true }
            .eraseToAnyPublisher()
    }
    
    var isIdMatchValid : AnyPublisher<IdState , Never> {
        Publishers.CombineLatest(isIdRegularExpression, isIdexist)
            .map {
                if $0 { return IdState.notStandard}
                if $1 { return IdState.idExist}
                return IdState.valid
            }.eraseToAnyPublisher()
    }
    
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
    
    private var isIdexist : AnyPublisher<Bool, Never> {
        $idText
            .dropFirst()
            .map { self.idList.contains($0) }
            .eraseToAnyPublisher()
    }
    
    private var isIdRegularExpression : AnyPublisher<Bool, Never> {
        let patten = "^[a-z0-9_-]{5,20}$"
        return $idText
            .dropFirst()
            .map { $0.range(of: patten, options: .regularExpression) == nil}
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
    
    private var namePasswordInputValid : AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isIdMatchValid, isPasswordValid)
            .map { $0 == .valid && $1 == .valid }
            .eraseToAnyPublisher()
    }
    
    private var passwordConfirmNameInputValid : AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isMatchPasswordValid, isNameValid)
            .map { $0 == .valid && $1 == .valid }
            .eraseToAnyPublisher()
    }
    
    private var idList = [String]()
    
    init() {
        service = Service()
        service.request { (resultList) in
            self.idList = resultList
        }
    }
    
}

//
//  ViewModel.swift
//  SignUp
//
//  Created by HOONHA CHOI on 2021/03/29.
//

import Foundation
import Combine

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
    
    var isMatchPassword : AnyPublisher<Bool, Never> {
        return self.$passwordText.combineLatest(self.$passwordConfirmText) {
            return $0 == $1
        }.eraseToAnyPublisher()
    }
    
    init() {
        $idText.sink { (idText) in
            self.isIdValid = self.countInputString(idText)
        }.store(in: &cancellable)
        
//        $passwordText.sink { (pwText) in
//
//        }.store(in: &cancellable)
//
            
        $nameText.sink { (nameText) in
        }.store(in: &cancellable)
    }
    
    func countInputString(_ string : String) -> Bool {
        return string.count > 4 && string.count <= 20
    }
}

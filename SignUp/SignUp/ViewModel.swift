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
    @Published var pwText = ""
    
    @Published var isIdValid = false
    @Published var isPwValid = false
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        $idText.sink { (idText) in
            self.isIdValid = self.countInputString(idText)
        }.store(in: &cancellable)
        
    }
    
    func countInputString(_ string : String) -> Bool {
        return string.count > 4 && string.count <= 20
    }
}

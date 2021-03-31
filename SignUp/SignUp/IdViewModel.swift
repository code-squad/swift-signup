//
//  IdViewModel.swift
//  SignUp
//
//  Created by HOONHA CHOI on 2021/03/31.
//

import Foundation
import Combine

class IdViewModel {
    
    @Published var idText = ""
    
    private var idList : [String] = []
    private var service : Service
    
    init() {
        service = Service()
        service.request { (resultList) in
            self.idList = resultList
        }
    }
    
    enum IdState2 : String {
        case idExist = "이미 사용중인 아이디입니다"
        case notStandard = "5~20자의 영문 소문자, 숫자와 특수기호(_)(-) 만 사용 가능합니다"
        case valid = "사용 가능한 아이디입니다"
    }
    
    var setTextRule : AnyPublisher<Bool, Never> {
        let pattern = "^[a-z0-9_-]{5,20}$"
        return $idText
            .dropFirst()
            .map { $0.range(of : pattern, options: .regularExpression) == nil }
            .eraseToAnyPublisher()
    }
    
    var isIdexist : AnyPublisher<Bool, Never> {
        return $idText
            .dropFirst()
            .map { self.idList.contains($0) }
            .eraseToAnyPublisher()
    }
    
    var isIdMatchValid : AnyPublisher<IdState , Never> {
        Publishers.Zip(setTextRule,isIdexist)
            .map {
                if $0 { return IdState.notStandard }
                if $1 { return IdState.idExist }
                return IdState.valid
            }.eraseToAnyPublisher()
    }
}

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
    private var cancellable : AnyCancellable?
    init() {
        service = Service()
        service.request { (resultList) in
            switch resultList {
            case .success(let data):
                self.idList = self.match(text: data)
            case .failure(let errr):
                print("err")
            }
            //self.idList = self.match(text: resultList)
        }
//        let stream = service.request.sink { (resultList) in
//            self.idList = self.match(text: resultList)
//        }
        
//        cancellable = AnyCancellable(stream)
    }
    
//    enum IdState : String, Validable {
//        func isValid() -> Bool {
//            self == .valid ? true : false
//        }
//        
//        case idExist = "이미 사용중인 아이디입니다"
//        case notStandard = "5~20자의 영문 소문자, 숫자와 특수기호(_)(-) 만 사용 가능합니다"
//        case valid = "사용 가능한 아이디입니다"
//    }
    
    var isIdMatchValid : AnyPublisher<IdState , Never> {
        Publishers.Zip(setTextRule,isIdexist)
            .map {
                if $0 { return IdState.notStandard }
                if $1 { return IdState.idExist }
                return IdState.valid
            }.eraseToAnyPublisher()
    }
    
    
    private var setTextRule : AnyPublisher<Bool, Never> {
        let pattern = "^[a-z0-9_-]{5,20}$"
        return $idText
            .dropFirst()
            .map { $0.range(of : pattern, options: .regularExpression) == nil }
            .eraseToAnyPublisher()
    }
    
    private var isIdexist : AnyPublisher<Bool, Never> {
        return $idText
            .dropFirst()
            .map { self.idList.contains($0) }
            .eraseToAnyPublisher()
    }
    
    private func match(text : String) -> [String] {
        guard let regex = try? NSRegularExpression(pattern: "[a-zA-Z]+", options: .caseInsensitive) else { return [] }
        let result = regex.matches(in: text, range: _NSRange(location: 0, length: text.count))
        return result.map {
            String(text[Range($0.range, in: text)!])
        }
    }
}

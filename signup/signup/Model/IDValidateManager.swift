//
//  IDValidateManager.swift
//  signup
//
//  Created by Song on 2021/03/31.
//

import Foundation

class IDValidateManager: ValidateManager {
    
    private var status: Status
    private let invalidMessages: [String]
    private let validMessage: String
    private let networkManager: NetworkManager
    
    init(status: Status, invalidMessages: [String], validMessage: String, networkManager: NetworkManager) {
        self.status = status
        self.invalidMessages = invalidMessages
        self.validMessage = validMessage
        self.networkManager = networkManager
    }
    
    convenience init() {
        let idStyleInvalid = "5~20자의 소문자, 숫자, 특수문자(_,-)만 입력 가능"
        let serverProblem = "일시적으로 서버 데이터를 확인할 수 없습니다"
        let idAlreadyExisting = "이미 존재하는 아이디입니다"
        
        let idValid = "사용 가능한 아이디입니다"
        
        let baseAddress = "https://8r6ruzgzve.execute-api.ap-northeast-2.amazonaws.com/default/SwiftCamp"
        
        self.init(status: Status(isValidated: false, message: ""),
                  invalidMessages: [idStyleInvalid,
                                    serverProblem,
                                    idAlreadyExisting],
                  validMessage: idValid,
                  networkManager: NetworkManager(baseAddress: baseAddress))
    }
    
    func check(_ inputs: [String]) -> Status {
        let id = inputs[0]
        status.isValidated = false
        
        guard let isExisting = isExisting(id) else {
            status.message = invalidMessages[1]
            return status
        }
        
        if !isStyleValid(id) {
            status.message = invalidMessages[0]
        } else if isExisting {
            status.message = invalidMessages[2]
        } else {
            status.isValidated = true
            status.message = validMessage
        }
        return status
    }
    
    private func isStyleValid(_ id: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[a-z0-9_-]{5,20}$",
                                             options: .anchorsMatchLines)
        let match = regex.firstMatch(in: id,
                                     options: .reportCompletion,
                                     range: .init(location: 0, length: id.count))
        return match != nil ? true : false
    }
    
    private func isExisting(_ id: String) -> Bool? {
        var isExisting: Bool?
        networkManager.isExisting(id: id, password: "") { (result) in
            isExisting = result
        }
        return isExisting
    }
}

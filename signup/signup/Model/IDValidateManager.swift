//
//  IDValidateManager.swift
//  signup
//
//  Created by Song on 2021/03/31.
//

import Foundation

class IDValidateManager: ValidateManager, ValidReturnable {
    
    private var status: Status
    private let invalidMessages: [String]
    private let validMessage: String
    
    private var validID: String?
    
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
    
    func validatedInput() -> String? {
        return validID
    }
    
    func isValid(_ input: String, completionHandler: @escaping (Status) -> Void) {
        validID = nil
        status.isValidated = false
        
        let id = input
        
        isExisting(id) { (result) in
            guard let result = result else {
                self.status.message = self.invalidMessages[1]
                completionHandler(self.status)
                return
            }
            
            if !self.isStyleValid(id) {
                self.status.message = self.invalidMessages[0]
            } else if result {
                self.status.message = self.invalidMessages[2]
            } else {
                self.status.isValidated = true
                self.status.message = self.validMessage
                self.validID = id
            }
            completionHandler(self.status)
        }
    }
    
    private func isStyleValid(_ id: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[a-z0-9_-]{5,20}$",
                                             options: .anchorsMatchLines)
        let match = regex.firstMatch(in: id,
                                     options: .reportCompletion,
                                     range: .init(location: 0, length: id.count))
        return match != nil ? true : false
    }
    
    private func isExisting(_ id: String, completionHandler: @escaping (Bool?) -> Void) {
        networkManager.isExisting(id: id, password: "") { (result) in
            completionHandler(result)
        }
    }
}

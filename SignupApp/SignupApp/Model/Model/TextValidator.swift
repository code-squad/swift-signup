//
//  Validator.swift
//  SignupApp
//
//  Created by Issac on 2021/04/01.
//

import Foundation

class TextValidator {
    var existIDs: [String]
    
    init() {
        existIDs = [String]()
        self.getIDsResponse { (existIDs) in
            self.existIDs = existIDs
        }
    }
    
    func checkFillNameIn(name: String, anotherText: [String]) -> ResultNameChecking {
        return name == ""
            && anotherText.filter{ $0 == "" }.isEmpty
            ? .blank
            : .correct
    }
    
    func checkEqualPassword(of password: String, anotherPassword: String) -> ResultEqualPasswordChecking {
        print(password, anotherPassword)
        switch anotherPassword {
        case "": return .blank
        case _ where anotherPassword == password: return .equal
        default: return .notEqual
        }
    }
    
    func checkPassword(of password: String) -> ResultPasswordChecking {
        switch password {
        case "": return .blank
        case _ where isOutOfCharacterLimitPassword(of: password): return .outOfCharacterLimit
        case _ where isNotIncludeUppercaseLetter(of: password): return .notIncludeUppercaseLetter
        case _ where isNotIncludeDigit(of: password): return .notIncludeDigit
        case _ where isNotIncludeSpecialCharacter(of: password): return .notIncludeSpecialCharacter
        default: return .correct
        }
    }
    
    func checkID(of ID: String) -> ResultIDChecking {
        switch ID {
        case "" : return .blank
        case _ where isExistID(ID: ID): return .existID
        case _ where isIncorrectID(ID: ID): return .incorrectID
        default: return .correct
        }
    }
    
    private func isOutOfCharacterLimitPassword(of password: String) -> Bool {
        return !password.match(for: "^.{8,16}$")
    }

    private func isNotIncludeUppercaseLetter(of password: String) -> Bool {
        return !password.match(for: "^.*[A-Z]{1,}.*$")
    }

    private func isNotIncludeDigit(of password: String) -> Bool {
        return !password.match(for: "^.*[\\d]+.*$")
    }

    private func isNotIncludeSpecialCharacter(of password: String) -> Bool {
        return !password.match(for: "^.*[\\!\\@\\#\\$\\%]+.*$")
    }

    private func isIncorrectID(ID: String) -> Bool {
        return !ID.match(for: "^[a-z\\d\\-\\_]{5,20}$")
    }
    
    private func isExistID(ID: String) -> Bool {
        return self.existIDs.contains(ID)
    }
    
    private func getIDsResponse(action: @escaping (([String]) -> ())) {
        let url = URL(string: "https://8r6ruzgzve.execute-api.ap-northeast-2.amazonaws.com/default/SwiftCamp")!
        
        NetworkCenter.shared.receiveIDData(url: url) { (data) in
            var existIDs = [String]()
            JSONResponseDecoder().decode(data: data, Object: [String].self) { (result, error) in
                guard let result = result else {
                    print(error!.localizedDescription)
                    return
                }
                existIDs = result
            }
            action(existIDs)
        }
    }
}

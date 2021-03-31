//
//  RegularExpression.swift
//  SignUp
//
//  Created by 오킹 on 2021/03/31.
//

import Foundation

struct RegularExpression {
    
    static private let pwRegularExpressionResponseMessage: [PwRegularExpression : String] = [.numberOfCharacters : "8자 이상 16자 이하로 입력해주세요.",
                                                                                             .minimumUppercase : "영문 대문자를 최소 1자 이상 포함해주세요.",
                                                                                             .minimumNumber : "숫자를 최소 1자 이상 포함해주세요.",
                                                                                             .minimumSpecialCharacter : "특수문자를 최소 1자 이상 포함해주세요."]
    
    static private let idRegularExpressionResponseMessage: [IdRegularExpression: String] = [.unavailableCharacter : "5~20자의 영문 소문자, 숫자와 특수기호(_)(-) 만 사용 가능합니다."]
   
    enum IdRegularExpression: String, CaseIterable {
        
        case unavailableCharacter = "^[a-zA-Z0-9-_]{5,20}$"
        
        func showMessage() -> String {
            return idRegularExpressionResponseMessage[self] ?? "사용할 수 없는 아이디 입니다."
         }
        
        var pattern: String {
            return self.rawValue
        }
    }
    
    enum PwRegularExpression: String, CaseIterable {
        
        case numberOfCharacters = ".{8,16}"
        case minimumUppercase = "[A-Z]+"
        case minimumNumber = "[0-9]+"
        case minimumSpecialCharacter = "[:punct:]+"
        
        func showMessage() -> String {
            return pwRegularExpressionResponseMessage[self] ?? "사용할 수 없는 비밀번호 입니다."
         }
        
        var pattern: String {
            return self.rawValue
        }
    }
}

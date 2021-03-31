import Foundation

enum IdCheck: CustomStringConvertible {
    case idCount
    case nonSupportedValue
    case valid
    
    var description: String {
        switch self {
        case .idCount: return "5~20자의 영문 소문자, 숫자, 특수문자(_,-)만 사용 가능합니다."
        case .nonSupportedValue: return "영문 소문자, 숫자, 특수문자(_,-)만 사용 가능합니다."
        case .valid: return "사용 가능한 아이디입니다."
        }
    }
}

enum PasswordCheck: CustomStringConvertible {
    case passwordCount
    case notContainedSpecialCharacters
    case valid
    
    var description: String {
        switch self {
        case .passwordCount: return "8~16자의 영문 대/소문자, 숫자, 특수문자(!@#$%)만 사용 가능합니다."
        case .notContainedSpecialCharacters: return "반드시 특수문자(!@#$%)가 포함되어야 합니다."
        case .valid: return "사용 가능한 비밀번호입니다."
        }
    }
}

enum PasswordConfirmCheck: CustomStringConvertible {
    case notEqul
    case valid
    
    var description: String {
        switch self {
        case .notEqul: return "비밀번호가 일치하지 않습니다."
        case .valid: return "비밀번호가 일치합니다."
        }
    }
}

enum NameCheck: CustomStringConvertible {
    case nameCount
    case valid
    
    var description: String {
        switch self {
        case .nameCount : return "2자 이상의 한글 이름을 입력해주세요."
        case .valid : return "사용 가능한 이름입니다."
        }
    }
}

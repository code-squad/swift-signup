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

import Foundation

enum LabelContetns: CustomStringConvertible {
    case idLabel
    case idPlaceholder
    case passwordLabel
    case passwordDoubleCheckLabel
    case passwordPlaceHolder
    case nameLabel
    
    var description: String {
        switch self {
        case .idLabel: return "아이디"
        case .idPlaceholder: return " 영문 소문자, 숫자, 특수기호(_,-), 5~20자"
        case .passwordLabel: return "비밀번호"
        case .passwordDoubleCheckLabel: return "비밀번호 확인"
        case .passwordPlaceHolder: return "영문 대/소문자, 숫자, 특수기호(!@#$%), 8~16자"
        case .nameLabel: return "이름"
        }
    }
}

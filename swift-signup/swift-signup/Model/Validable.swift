
import Foundation

enum TextState {
    case begin
    case valid
    case invalid
}

protocol Validable {
    func state() -> TextState
}

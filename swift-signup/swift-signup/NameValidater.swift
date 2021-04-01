
import Foundation
import UIKit

class NameValidater {
    
    enum State {
        case begin
        case valid
        case invalid
        case end
    }
    
    private var currentState: State
    
    init() {
        self.currentState = .begin
    }
    
    func evaluate(with text: String) -> [AnyHashable:Any] {
        if text.isEmpty {
            self.currentState = .invalid
        } else {
            self.currentState = .valid
        }
        
        return message(about: self.currentState)
    }
    
    func message(about state: State) -> [AnyHashable:Any] {
        var messageInfo : [AnyHashable:Any] = [:]

        switch state {
        case .invalid:
            messageInfo.updateValue("이름은 필수 입력 항목입니다.", forKey: NameValidater.MessageInfo.text)
            messageInfo.updateValue(UIColor.red, forKey: NameValidater.MessageInfo.color)
        default:
            break
        }
        
        return messageInfo
    }
    
    func state() -> State {
        return self.currentState
    }
    
    func exitTextField() {
        if self.currentState == .valid {
            self.currentState = .end
        }
    }
}

extension NameValidater {
    enum MessageInfo {
        case text
        case color
    }
}

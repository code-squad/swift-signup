
import Foundation
import UIKit

class PasswordConfirmValidater {
    
    enum State {
        case begin
        case valid
        case invalid
        case end
    }
    
    private var currentState: State
    private var password: String
    
    init() {
        self.currentState = .begin
        self.password = ""
    }
    
    func evaluate(with text: String) -> [AnyHashable:Any] {
        
        if self.password == text {
            self.currentState = .valid
        } else {
            self.currentState = .invalid
        }
        
        return message(about: self.currentState)
    }
    
    func message(about state: State) -> [AnyHashable:Any] {
        var messageInfo : [AnyHashable:Any] = [:]

        switch state {
        case .valid:
            messageInfo.updateValue("비밀번호가 일치합니다.", forKey: PasswordConfirmValidater.MessageInfo.text)
            messageInfo.updateValue(UIColor.systemGreen, forKey: PasswordConfirmValidater.MessageInfo.color)
        case .invalid:
            messageInfo.updateValue("비밀번호가 일치하지 않습니다.", forKey: PasswordConfirmValidater.MessageInfo.text)
            messageInfo.updateValue(UIColor.red, forKey: PasswordConfirmValidater.MessageInfo.color)
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
    
    func update(password: String) {
        self.password = password
    }
}

extension PasswordConfirmValidater {
    enum MessageInfo {
        case text
        case color
    }
}


import Foundation
import UIKit

class IdValidater {
    
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
        let idRegularExpression = "[a-z0-9_-]{5,20}"
        let validString = NSPredicate(format: "SELF MATCHES %@", idRegularExpression)
        
        if validString.evaluate(with: text) {
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
            messageInfo.updateValue("사용 가능한 아이디입니다.", forKey: IdValidater.MessageInfo.text)
            messageInfo.updateValue(UIColor.systemGreen, forKey: IdValidater.MessageInfo.color)
        case .invalid:
            messageInfo.updateValue("5~20자의 영문 소문자, 숫자와 특수기호(_)(-)만 사용 가능합니다.", forKey: IdValidater.MessageInfo.text)
            messageInfo.updateValue(UIColor.red, forKey: IdValidater.MessageInfo.color)
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

extension IdValidater {
    enum MessageInfo {
        case text
        case color
    }
}


import Foundation
import UIKit

class IdValidater2 : Validable {
    
    private var currentState: TextState
    
    init() {
        self.currentState = .begin
    }
    
    func evaluate(with text: String) -> [AnyHashable:Any] {
        let idRegularExpression = "[a-z0-9_-]{5,20}"
        let validString = NSPredicate(format: "SELF MATCHES %@", idRegularExpression)
        
        var messageInfo : [AnyHashable:Any] = [:]

        if validString.evaluate(with: text) {
            messageInfo.updateValue("사용 가능한 아이디입니다.", forKey: Validater.MessageInfo.text)
            messageInfo.updateValue(UIColor.systemGreen, forKey: Validater.MessageInfo.color)
            self.currentState = .valid
        } else {
            messageInfo.updateValue("5~20자의 영문 소문자, 숫자와 특수기호(_)(-)만 사용 가능합니다.", forKey: Validater.MessageInfo.text)
            messageInfo.updateValue(UIColor.red, forKey: Validater.MessageInfo.color)
            self.currentState = .invalid
        }
        
        return messageInfo
    }
    
    func state() -> TextState {
        return self.currentState
    }
}

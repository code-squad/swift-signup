
import Foundation
import UIKit

class NameValidater2 : Validable {
    
    private var currentState: TextState
    
    init() {
        self.currentState = .begin
    }
    
    func evaluate(with text: String) -> [AnyHashable:Any] {

        var messageInfo : [AnyHashable:Any] = [:]

        if text == "" {
            messageInfo.updateValue("이름은 필수 입력 항목입니다.", forKey: Validater.MessageInfo.text)
            messageInfo.updateValue(UIColor.red, forKey: Validater.MessageInfo.color)
            self.currentState = .invalid
        } else {
            messageInfo.updateValue("", forKey: Validater.MessageInfo.text)
            messageInfo.updateValue(UIColor.systemGreen, forKey: Validater.MessageInfo.color)
            self.currentState = .valid
        }
        
        return messageInfo
    }
    
    func state() -> TextState {
        return self.currentState
    }
}

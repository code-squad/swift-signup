
import Foundation
import UIKit

class PasswordConfirmValidater2 {
    
    private var password: String
    
    init() {
        self.password = ""
    }
    
    func evaluate(with text: String) -> [AnyHashable:Any] {

        var messageInfo : [AnyHashable:Any] = [:]

        if isEqual(password: text) {
            messageInfo.updateValue("비밀번호가 일치합니다.", forKey: Validater.MessageInfo.text)
            messageInfo.updateValue(UIColor.systemGreen, forKey: Validater.MessageInfo.color)
        } else {
            messageInfo.updateValue("비밀번호가 일치하지 않습니다.", forKey: Validater.MessageInfo.text)
            messageInfo.updateValue(UIColor.red, forKey: Validater.MessageInfo.color)
        }
        
        return messageInfo
    }
    
    func update(password: String) {
        self.password = password
    }
    
    func isEqual(password: String) -> Bool {
        return self.password == password
    }
}

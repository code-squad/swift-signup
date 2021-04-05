
import Foundation
import UIKit

class PasswordValidater2 : Validable {
    
    private var currentState: TextState
    
    init() {
        self.currentState = .begin
    }
    
    func evaluate(with text: String) -> [AnyHashable:Any] {
        let capitalRegularExpression = "[A-Z]+"
        let numberRegularExpression = "[0-9]+"
        let specialRegularExpression = "[!@#$%^&*()_+=-]+"
        
        var messageInfo : [AnyHashable:Any] = [:]

        if text.count < 8 || text.count > 16
        {
            messageInfo.updateValue("8자 이상 16자 이하로 입력해주세요.", forKey: Validater.MessageInfo.text)
            messageInfo.updateValue(UIColor.red, forKey: Validater.MessageInfo.color)
            self.currentState = .invalid
        }
        else if match(regularExpression: capitalRegularExpression, with: text) == false
        {
            messageInfo.updateValue("영문 대문자를 최소 1자 이상 포함해주세요.", forKey: Validater.MessageInfo.text)
            messageInfo.updateValue(UIColor.red, forKey: Validater.MessageInfo.color)
            self.currentState = .invalid
        }
        else if match(regularExpression: numberRegularExpression, with: text) == false
        {
            messageInfo.updateValue("숫자를 최소 1자 이상 포함해주세요.", forKey: Validater.MessageInfo.text)
            messageInfo.updateValue(UIColor.red, forKey: Validater.MessageInfo.color)
            self.currentState = .invalid
        }
        else if match(regularExpression: specialRegularExpression, with: text) == false
        {
            messageInfo.updateValue("특수문자를 최소 1자 이상 포함해주세요.", forKey: Validater.MessageInfo.text)
            messageInfo.updateValue(UIColor.red, forKey: Validater.MessageInfo.color)
            self.currentState = .invalid
        }
        else
        {
            messageInfo.updateValue("안전한 비밀번호입니다.", forKey: Validater.MessageInfo.text)
            messageInfo.updateValue(UIColor.systemGreen, forKey: Validater.MessageInfo.color)
            self.currentState = .valid
        }
        
        return messageInfo
    }
    
    func match(regularExpression: String, with string: String) -> Bool {
        let validString = try? NSRegularExpression(pattern: regularExpression, options: [])
        
        return validString?.firstMatch(in: string, options: [], range: NSRange(location: 0, length: string.count)) != nil
    }
    
    func state() -> TextState {
        return self.currentState
    }
}
